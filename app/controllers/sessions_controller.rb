class SessionsController < ApplicationController

  def new
  end

  def create
    if User.authenticate(params[:email], params[:password])
      session[:user_id] = User.find_by_email(params[:email]).id  
      flash[:alert] = "You have been logged in."
      redirect_to admin_url
    else
      flash[:alert] = "Your email or password could not be validated. Please try again."
      redirect_to action: 'new'
    end
  end
    
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
end

