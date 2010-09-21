# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

RMGR_CMD = "curl -I --basic -u 'admin:admin' http://localhost:3001/farms/start_by_role"

#scratch space for s3
S3_SCRATCH_SPACE = "daustin-test:qips_scratch/"

# how long wfmgr waits between executing each task.  set to at least 60 seconds in production for use wih qips-node
PROCESS_WAIT_TIME = 5

#active resource site
RMGR_SITE = 'http://admin:admin@localhost:3001'

#active resource lims site
ILIMS_SITE = 'http://admin:admin@localhost:3002'

# wget command.  must be quiet and output to stdout. and not check certs
WGET_CMD = 'wget -q --no-check -O -' 

# public link to lims site
PUBLIC_ILIMS_SITE = 'http://localhost:3002'