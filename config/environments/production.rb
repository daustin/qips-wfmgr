# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Enable threaded mode
# config.threadsafe!

RMGR_CMD = "curl -I --basic -u 'admin:admin' http://aws.itmat.upenn.edu/rmgr/farms/start_compute_instances/"

#scratch space for s3
S3_SCRATCH_SPACE = "itmat-qips:scratch/"

# how long wfmgr waits between executing each task.  set to at least 60 seconds in production for use wih qips-node
PROCESS_WAIT_TIME = 60

#active resource site
RMGR_SITE = 'http://admin:admin@localhost/rmgr'

#active resource lims site
ILIMS_SITE = 'http://admin:admin@localhost/ilims'

# wget command.  must be quiet and output to stdout. and not check certs
WGET_CMD = 'wget -q --no-check -O -' 

# public link to lims site
PUBLIC_ILIMS_SITE = 'http://aws.itmat.upenn.edu/ilims'
