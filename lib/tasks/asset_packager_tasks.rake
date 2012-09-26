require File.join(File.dirname(__FILE__), '..', 'synthesis', 'asset_package')

namespace :asset do
  namespace :packager do
    desc 'Merge and compress assets'
    task :build_all do
      Synthesis::AssetPackage.build_all
    end

    desc 'Delete all asset builds'
    task :delete_all do
      Synthesis::AssetPackage.delete_all
    end

    desc 'Generate asset_packages.yml from existing assets'
    task :create_yml do
      Synthesis::AssetPackage.create_yml
    end

    desc "Validate Javascript with JSLint"
    task :validate do
      class String
        # colorize functions
        def red;        colorize(self, "\e[1m\e[31m"); end
        def green;      colorize(self, "\e[1m\e[32m"); end
        def dark_green; colorize(self, "\e[32m"); end
        def yellow;     colorize(self, "\e[1m\e[33m"); end
        def blue;       colorize(self, "\e[1m\e[34m"); end
        def dark_blue;  colorize(self, "\e[34m"); end
        def pur;        colorize(self, "\e[1m\e[35m"); end
        def bold;       colorize(self, "\e[1m\e[35m"); end
        def colorize(text, color_code, bold = false)
          "#{color_code}#{text}\e[0m"
        end
      end

      conf_path = File.join(File.dirname(__FILE__), '..', '..', 'jslint.conf')

      puts "Validating with JSLint"
      puts
      Synthesis::AssetPackage.asset_list['javascripts'].each do |set|
        set.each do |pack, files|
          files.each do |file|
            path = File.join(Synthesis::AssetPackage.asset_base_path, 'javascripts', file) + '.js'
            output = `cat "#{Shellwords.shellescape path}" | jsl -stdin -nologo -nologo -nosummary -conf #{Shellwords.shellescape conf_path}`

            puts
            print path

            if output.blank?
              print " OK ".green
            else
              puts
              print output.gsub('lint warning:', "#{'lint warning'.yellow}:").
                gsub('html error:', "#{'html error'.red}:").
                gsub('SyntaxError:', "#{'SyntaxError'.red}:").
                gsub(' warning:', "#{' warning'.yellow}:")
            end
            source = File.open(path, 'r:utf8', &:read)
            res = Synthesis::Compiler::Uglify.compress(source)
            puts "Size #{source.size / 1024}KB, compression #{100 - (res.size.to_f / source.size * 100).to_i}%"
          end
        end
      end
      puts
    end
  end
end
