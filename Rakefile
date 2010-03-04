# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "qips-wfmgr"
    gemspec.summary = "QIPS - Workflow Manager"
    gemspec.description = "Workflow Manager is in charge of creating, submitting, and tracking custom workflows."
    gemspec.email = "daustin@mail.med.upenn.edu"
    gemspec.homepage = "http://github.com/daustin/qips-wfmgr"
    gemspec.authors = ["Dave Austin","Andrew Brader"]
  end
  Jeweler::GemcutterTasks.new
  rescue LoadError
    puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
