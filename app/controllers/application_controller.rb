# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  before_filter :login_required
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
       username == "admin" && password == "admin"
    end
  end
  
  def restrict_to_admin
    
    unless current_user.admin?
      flash[:error] = "You do not have admin. Please log in again."
      store_target_location
      redirect_to login_url
      return
    end
  end


end
