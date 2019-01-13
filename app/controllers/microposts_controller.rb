class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            # flash[:success] = "Micropost created!"
            redirect_back(fallback_location: current_user)
        else
            # flash[:alert] = "Post not created"
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
    end

    private

        def micropost_params
            params.require(:micropost).permit(:content)
        end
end
