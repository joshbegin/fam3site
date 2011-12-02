class UsersController < ApplicationController
  before_filter :get_user, :only => [:show, :edit, :update, :destroy]
  before_filter :user_auth, :only => [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def user_auth
    if session[:user_id] != @user.id
      flash[:failure] = "Users can only change their own account"
      redirect_to :back
    end
  end
  
  def get_user
    @user = User.find(params[:id])
  end
  
  # GET /users
  # GET /users.json
  def index
    if current_user
      @title = "Users"
      @search = User.search(params[:search])
      @users = @search.all
     # @users = User.order(sort_column + ' ' + sort_direction)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      flash[:failure] = "Must be logged in to view Users"
      redirect_to root_path 
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user
      @title = "User details"

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      flash[:failure] = "Must be logged in to view Users"
      redirect_to root_path 
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @title = "Create user"
    @user = User.new
    
    if current_user
      flash[:failure] = "Only new users can sign up"
      redirect_to users_path
    else
      3.times do
        @user.phones.build
      #@user.addresses.build
      #@user.emails.build
      end
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    end
    
  end

  # GET /users/1/edit
  def edit
    @title = "Edit user"
  end

  # POST /users
  # POST /users.json
  def create
    @title = "Create user"
    @user = User.new(params[:user])
    
    unless current_user
      respond_to do |format|
        if @user.save
          session[:user_id] = @user.id
          format.html { 
            flash[:success] = "User \"#{@user.username}\" was successfully created."
            redirect_to @user 
            }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @title = "Edit user"

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { 
          flash[:success] = "User was successfully updated."
          redirect_to @user
          }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @title = "Delete user"
    @user.destroy
    session[:user_id] = nil

    respond_to do |format|
      format.html { 
        flash[:success] = "User was successfully deleted."
        redirect_to root_path
        }
      format.json { head :ok }
    end
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
      @search = User.search(params[:search])
      @users = @search.all

      @home_phones = Phone.search :phone_type_id_equals => 1
#      @home_phones = Phone.where "phone_type_id = 1"
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
  
  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"  
  end
end
