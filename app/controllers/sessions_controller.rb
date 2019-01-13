class SessionsController < ApplicationController
  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      user.update(is_signed_in: true)
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    user = User.find(current_user.id)
    log_out if logged_in?
    user.update(is_signed_in: false)
    flash[:success] = "Logged out. Come back soon and see more features!"
    redirect_to root_url
  end

end
