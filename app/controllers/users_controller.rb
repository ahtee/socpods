class UsersController < ApplicationController
  # Choose user_profile layout instead of the default
  # layout 'user_profile'

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @user = User.new
  end

  def show
    @user = User.find_by(username: params[:id])
    @micropost = current_user.microposts.build if logged_in?
    @microposts = @user.microposts.paginate(page: params[:page])
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
      log_in @user
      flash[:success] = 'Welcome to the Social Network! We\'re excited you joined us. Learn more.'
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
      flash[:success] = "Profile successfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User has been successfully deleted."
    redirect_to root_url
  end

  def createPost 
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
        flash[:success] = "Micropost created!"
        render 'users/show'
    else
        flash[:alert] = "Post not created"
        render 'users/show'
    end
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

    def micropost_params
      params.require(:micropost).permit(:content)
  end

end
