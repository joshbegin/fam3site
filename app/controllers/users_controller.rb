class UsersController < ApplicationController
  before_filter :get_user, :only => [:show, :edit, :update, :destroy]
  before_filter :user_auth, :only => [:edit, :update, :destroy]
  
  def user_auth
    if session[:user_id] != @user.id
      redirect_to users_path,
        :notice => "Users can only change their own account"
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
      @users = User.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      redirect_to root_path, :notice => "Must be logged in to view Users" 
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
    
    if current_user
      redirect_to users_path, notice: "Only new users can sign up"
    else
      1.times { @user.phones.build }
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
          format.html { redirect_to @user, notice: "User #{@user.username} was successfully created." }
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :ok }
    end
  end
  
def birthdates
    if current_user
      @title = "Birthdates"
      @users = User.all
      @user_months = @users.group_by { |t| t.birthdate.beginning_of_month }

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      redirect_to root_path, :notice => "Must be logged in to view users" 
    end
  end
  
end
