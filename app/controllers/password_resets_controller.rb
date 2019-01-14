class PasswordResetsController < ApplicationController
  def new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to login_url
    else
      flash.now[:danger] = "Email address not found. Please try entering your email again."
      render 'new'
    end
  end
end
