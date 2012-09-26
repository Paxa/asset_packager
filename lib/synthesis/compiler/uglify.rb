module Synthesis
  module Compiler
    class Uglify
      class << self
        def description
          "UglifyJS running from gem 'uglifier'."
        end

        def compress(source)
          require 'uglifier'

          begin
            Uglifier.new(:ascii_only => false).compile(source)
          rescue => e
            if e.is_a?(ExecJS::ProgramError) && e.message =~ /line:/
              line_num = e.message.match(/line:\s*(\d+)/)[1].to_i
              start_line = line_num > 5 ? line_num - 5 : 0
              lines = source.split(/$/)[start_line .. line_num + 5]

              lines.each_with_index do |line, i|
                lines[i] = ("%6d: " % (i + start_line - 1)) + line.strip
              end.join("\n")

              puts "Parse error happen on line #{line_num}"
              puts lines
            end
            raise e
          end
        end
      end
    end
  end
end

Synthesis::AssetPackage.add_compiler(Synthesis::Compiler::Uglify)