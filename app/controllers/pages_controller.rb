class PagesController < ApplicationController
  def home
    @title = "Home"
    @users = User.all

    if current_user
      redirect_to users_path
    end
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

  def birthdates
    if current_user
      @title = "Birthdates"
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
      @title = "Phone Numbers"
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
end
