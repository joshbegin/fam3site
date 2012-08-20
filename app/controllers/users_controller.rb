class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :get_user, :only => [:edit, :update, :destroy]
  before_filter :user_auth, :only => [:edit, :update, :destroy]
 
  #need to add rescue ActiveRecord::RecordNotFound, etc...

  def user_auth
    unless session[:user_id] == @user.id
      flash[:failure] = "Users can only change their own account"
      redirect_to users_path
    end
  end
  
  def get_user
    @user = User.find(params[:id])
  end
  
  # GET /users
  # GET /users.json
  def index
    if current_user
      # .search is used by meta_search
      @search = User.search(params[:search])
      @users = @search.all
    
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
      begin
        @title = "User details"
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:failure] = "User does not exist"
        redirect_to users_path     
      else
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @user }
        end
      end
    else
      flash[:failure] = "Must be logged in to view Users"
      redirect_to root_path

    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    
    if current_user
      flash[:failure] = "Only new users can sign up"
      redirect_to users_path
    else
      3.times { @user.phones.build }
      3.times { @user.addresses.build }
      3.times { @user.emails.build }
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    end
    
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
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
  
end
