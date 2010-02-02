# lib/tasks/ruote.rake
namespace :ruote do
  desc "Run a worker thread for Ruote"
  task :run_worker => :environment do
    Ruote.run_worker!
  end
end

