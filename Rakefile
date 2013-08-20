require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "uk_working_days"
    gem.summary = %Q{Provide date helpers for UK working days}
    gem.description = %Q{Provide date helpers for UK working days}
    gem.email = "roland.swingler@gmail.com"
    gem.homepage = "http://github.com/notonthehighstreet/working_days"
    gem.authors = ["Roland Swingler"]
    gem.add_dependency "activesupport", ">= 3"
    gem.add_development_dependency "shoulda", ">= 0"
    gem.add_development_dependency "rake"
    gem.add_development_dependency "pry"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :default => :test
