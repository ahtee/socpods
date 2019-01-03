class UsersController < ApplicationController
  
  def index
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :username, :email, :password,
                                   :password_confirmation)
    end

end
