class UsersController < ApplicationController
  before_filter :get_user, :only => [:show, :edit, :update, :destroy]
  before_filter :user_auth, :only => [:edit, :update, :destroy]
  
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
      @users = User.ordered.all

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
    @title = "User details"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @title = "Create user"
    @user = User.new
    puts "\n\n\n\n Here I am in new\n\n\n\n"

    if current_user
      flash[:failure] = "Only new users can sign up"
      redirect_to users_path
    else
      #1.times do
        @user.phones.build
        @user.addresses.build
        @user.emails.build
      #end
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
    puts "\n\n\n\n Here I am in create\n\n\n\n"

    unless current_user
      respond_to do |format|
        if @user.save
          session[:user_id] = @user.id
          format.html { 
            flash[:success] = "User #{@user.username} was successfully created."
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

    respond_to do |format|
      format.html { 
        flash[:success] = "User was successfully deleted."
        redirect_to users_url
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
  
end
