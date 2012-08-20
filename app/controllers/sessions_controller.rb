class SessionsController < ApplicationController
  def new
    @title = "Log in"
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      sign_in user
      # session[:user_id] = user.id
      if user.first_name == "Sharon" && user.last_name == "Begin"
        flash[:success] = "Welcome, Beautiful Wife!"
      elseif user.first_name == "Joseph" && user.last_name == "Begin"
        flash[:success] = "Welcome, Dad!"
      else
        flash[:success] = "Welcome, #{user.first_name}!"
      end
      redirect_back_or users_path
    else
      flash.now[:failure] = "Invalid username or password"
      render 'new'
    end
  end

  def destroy
    @title = "Log out"
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end

