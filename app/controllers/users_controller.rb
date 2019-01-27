class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @user = current_user unless !logged_in?
  end

  def show
    @user = User.find_by(username: params[:id])
    if logged_in?
      @comment = current_user.comments.build
      if @comment.save 
        render :show
      end
    end

    @profile_comments = @user.comments.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  # New user form initially
  def new
    @user = User.new
  end

  def edit
  end

  def friends
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = 'Welcome to the Social Network!'
      redirect_to @user
    else
      flash[:danger] = 'Oops! Something went wrong. Email is already registered or the form is filled incorrectly.'
      render 'welcome/index'
    end
  end

  def update
    @user = User.find_by(username: params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Your profile successfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User has been deleted."
    redirect_to root_url
  end

  def add_friend
  end
    
  def remove_friend  
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :email, :password,
                                   :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find_by(username: params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
