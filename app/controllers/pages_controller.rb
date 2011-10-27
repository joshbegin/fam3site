class PagesController < ApplicationController
  def home
    @title = "Home"
    @user = User.first
    @users = User.all
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

end
