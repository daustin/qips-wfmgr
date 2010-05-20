class SessionsController < ApplicationController
  skip_before_filter :login_required, :except => :destroy
  def new
  end

  def create
    user = User.get(:authenticate, :username => params[:login], :password => params[:password])
  
    if user.empty? || user['id'].nil?
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
  
    else
     session[:user_id] = user['id']
      flash[:notice] = "Logged in successfully."
      redirect_to workflows_path
    end
 
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
