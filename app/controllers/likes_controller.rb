class LikesController < ApplicationController
    before_action :authenticate_user!
  
    def create
        @post = Post.find(params[:post_id])
        @like = current_user.likes.build(post: @post)
        
        if @like.save
          redirect_to @post, notice: 'Post liked!'
        else
          redirect_to @post, alert: 'Could not like post.'
        end
    end
  
    def destroy
        @post = Post.find(params[:post_id])
        @like = current_user.likes.find_by(post: @post)
        
        if @like.destroy
          redirect_to @post, notice: 'Like removed.'
        else
          redirect_to @post, alert: 'Could not remove like.'
        end
    end
end