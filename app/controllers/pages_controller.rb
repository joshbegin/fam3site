class PagesController < ApplicationController
  before_filter :signed_in_user, only: [:birthdates, :phones, :addresses]
  # before_filter :get_user, :only => [:birthdates, :phones, :addresses]
  # before_filter :user_auth, :only => [:birthdates, :phones, :addresses]

  def home
    @users = User.all

    if current_user
      redirect_to users_path
    end
  end

  def about
    # @title = "About"
  end

  def contact
    # @title = "Contact"
  end

  def birthdates
    if current_user
      # @title = "Birthdates"
      @users = User.all
      @user_months = @users.group_by { |t| t.birthdate.month }

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      flash[:failure] = "Must be logged in to view users"
      redirect_to root_path
    end
  end

  def phones
    if current_user
      # @title = "Phone Numbers"
      @search = Phone.search(params[:search])
      @users = @search.all

      @home_phones = Phone.search :phone_type_id_equals => 1
      @work_phones = Phone.where "phone_type_id = 2"
      @cell_phones = Phone.where "phone_type_id = 3"
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      flash[:failure] = "Must be logged in to view users"
      redirect_to root_path
    end
  end

  def addresses
    if current_user
      # @title = "Addresses"
      @search = User.search(params[:search])
      @users = @search.all
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      flash[:failure] = "Must be logged in to view users"
      redirect_to root_path
    end
  end
end
