class SessionsController < ApplicationController
  skip_before_filter :login_required, :except => :destroy
  def new
  end

  def create
    user = User.get(:authenticate, :username => params[:login], :password => params[:password])
  
    if user
      session[:user_id] = user['id']
      flash[:notice] = "Logged in successfully."
      redirect_to workflows_path
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
