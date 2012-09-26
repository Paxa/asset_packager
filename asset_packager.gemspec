# encoding: utf-8

Gem::Specification.new do |s|
  s.name = "asset_packager"
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Becker", "Brady Bouchard", "Igor Galeta"]
  s.date = "2012-09-26"
  s.description = "This Rails plugin makes it simple to merge and compress JavaScript and CSS for production use, increasing speed and saving bandwidth. Uses UglifyJS on NodeJS, Google's Closure Compiler or Douglas Crockford's JSMin."

  s.email             = "pavel.evst@gmail.com"
  s.extra_rdoc_files  = ["README.rdoc"]
  s.files             = `git ls-files`.split("\n")
  s.homepage          = "https://github.com/Paxa/asset_packager"
  s.require_paths     = ["lib"]
  s.rubyforge_project = "asset_packager"
  s.rubygems_version  = "1.8.24"
  s.summary           = "JavaScript and CSS Asset Compression for Production Rails Apps"

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end
end

