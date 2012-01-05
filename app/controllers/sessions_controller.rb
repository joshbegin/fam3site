class SessionsController < ApplicationController
  def new
    @title = "Log in"
  end

  def create
    @title = "Log in"
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.first_name == "Sharon" && user.last_name == "Begin"
        flash[:success] = "Welcome, Beautiful Wife!"
      elseif user.first_name == "Joseph" && user.last_name == "Begin"
        flash[:success] = "Welcome, Dad!"
      else
        flash[:success] = "Welcome, #{user.first_name}!"
      end
      redirect_to users_path
    else
      flash[:failure] = "Invalid username or password"
      render :action => 'new'
    end
  end

  def destroy
    @title = "Log out"
    session[:user_id] = nil
    flash[:success] = "Logged out!"
    redirect_to root_url
  end
end

