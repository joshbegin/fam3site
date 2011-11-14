class SessionsController < ApplicationController
  def new
    @title = "Log in"
  end

  def create
    @title = "Log in"
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_path, :notice => "Welcome, #{user.first_name}!"
    else
      #flash.now.alert = "Invalid username or password"
      redirect_to signin_path, :notice => "Invalid username or password"
    end
  end

  def destroy
    @title = "Log out"
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end

