# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "create_deployment_record"
  gem.homepage = "http://github.com/IntersectAustralia/create_deployment_record"
  gem.license = "MIT"
  gem.summary = %Q{Capistrano task to create deployment record}
  gem.description = %Q{Capistrano task to create deployment record}
  gem.email = "danielt@intersect.org.au"
  gem.authors = ["danieltheodosius"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "create_deployment_record #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
