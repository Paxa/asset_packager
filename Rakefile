require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), 'lib', 'synthesis', 'version')

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the asset_packager plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the asset_packager plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AssetPackager'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('Readme.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end