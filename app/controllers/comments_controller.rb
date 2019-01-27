class CommentsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]

    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            # flash[:success] = "Micropost created!"
            redirect_back(fallback_location: current_user)
        else
            # flash[:alert] = "Post not created"
            redirect_back(fallback_location: root_path)
        end
    end

    def update
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            render :show
        else
            redirect_to root_url
        end
      end

    def destroy
    end

    private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
