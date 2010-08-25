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
    
    gemspec.add_dependency "sqlite3-ruby"
    gemspec.add_dependency 'sinatra', '=0.9.4'
    gemspec.add_dependency 'sinatra-respond_to', "=0.4.0"
    gemspec.add_dependency "json", ">=1.2.0"
    gemspec.add_dependency "right_aws", ">=1.10.0"
    gemspec.add_dependency "ruote", '=2.1.4'
    gemspec.add_dependency "ruote-amqp", '=2.1.5'
    gemspec.add_dependency 'ruote-kit', '=2.1.4.1'
        
    # testing gems!
    gemspec.add_development_dependency 'rspec-rails', '>=1.3.2'
    gemspec.add_development_dependency "rspec", ">=1.2.9"
    gemspec.add_development_dependency "cucumber", ">=0.4.3"
    gemspec.add_development_dependency "pickle", ">=0.1.21"
    gemspec.add_development_dependency 'cucumber-rails', '>=0.3.0'
    gemspec.add_development_dependency 'database_cleaner', '>=0.5.0'
    gemspec.add_development_dependency 'webrat', '>=0.7.0' 
    gemspec.add_development_dependency "capybara", "=0.3.8"
        
  end
  Jeweler::GemcutterTasks.new
  rescue LoadError
    puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
