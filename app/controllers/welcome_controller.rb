class WelcomeController < ApplicationController
  def index
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      log_in @user
      flash[:success] = 'Welcome to the Social Network! We\'re excited you joined us. Learn more.'
      redirect_to @user
    else
      flash[:danger] = 'Oops! Something went wrong. Please ensure the signup form is correct and try again.'
      render 'welcome/index'
    end
  end

  def feed
    Micropost.where("user_id = ?", id)
  end

  private 
    
    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
