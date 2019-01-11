class UsersController < ApplicationController
  # Choose user_profile layout instead of the default
  # layout 'user_profile'

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  # before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: FILL_IN).paginate(page: params[:page])
  end

  def show
    @user = User.find_by(username: params[:id])
    # debugger
    redirect_to root_url and return unless FILL_IN
  end
  
  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      @user.send_activation_email # previously: log_in @user
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url # previously: redirect_to @user
    else
      flash[:danger] = 'Oops! Something went wrong. Email is already registered or the form is filled incorrectly.'
      redirect_to root_url
    end
  end

  def update
    @user = User.find_by(username: params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile successfully updated."
      render 'edit'
    else
      flash[:warning] = "Profile settings were not updated."
      render 'edit'
    end
  end

  def destroy
    User.find_by(username: params[:id]).destroy
    redirect_to root_url
    flash[:success] = "User has been successfully deleted."
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :email, :password,
                                   :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in to continue."
        redirect_to login_url
      end
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
