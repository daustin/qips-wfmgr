# Edit at your own peril - it's recommended to regenerate this file
# in the future when you upgrade to a newer version of Cucumber.

# IMPORTANT: Setting config.cache_classes to false is known to
# break Cucumber's use_transactional_fixtures method.
# For more information see https://rspec.lighthouseapp.com/projects/16211/tickets/165
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false

# Disable request forgery protection in test environment
config.action_controller.allow_forgery_protection    = false

# Tell Action Mailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

out = `jruby --version`
raise "please install jruby: \ninstall: jruby\n then run: jruby -S gem install celerity" unless out =~ /^jruby \d+.*/


config.gem 'cucumber-rails',   :lib => false, :version => '>=0.3.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/cucumber-rails'))
config.gem 'database_cleaner', :lib => false, :version => '>=0.5.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/database_cleaner'))
config.gem 'capybara',         :lib => false, :version => '>=0.3.0' unless File.directory?(File.join(Rails.root, 'vendor/plugins/capybara'))


RMGR_CMD = "curl -I --basic -u 'admin:admin' http://localhost:3001/farms/start_compute_instances/"

#scratch space for s3
S3_SCRATCH_SPACE = "daustin-test:qips_scratch/"

# how long wfmgr waits between executing each task.  set to at least 60 seconds in production for use wih qips-node
PROCESS_WAIT_TIME = 5

#active resource site
RMGR_SITE = 'http://admin:admin@localhost:3001'

#active resource lims site
ILIMS_SITE = 'http://admin:admin@localhost:3002'

# user id for user 'test' in ilims
ILIMS_USER_ID = 3

# wget command.  must be quiet and output to stdout. and not check certs
WGET_CMD = 'wget -q --no-check -O -' 

# public link to lims site
PUBLIC_ILIMS_SITE = 'http://localhost:3002'



