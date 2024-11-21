class FollowsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @user = User.find(params[:user_id])
      
      # Prevent following yourself
      if current_user == @user
        redirect_to @user, alert: "You cannot follow yourself"
        return
      end
  
      # Create the follow relationship
      if current_user.follow(@user)
        redirect_to @user, notice: "You are now following #{@user.email}"
      else
        redirect_to @user, alert: "Could not follow user"
      end
    end
  
    def destroy
      @user = User.find(params[:user_id])
      
      if current_user.unfollow(@user)
        redirect_to @user, notice: "You have unfollowed #{@user.email}"
      else
        redirect_to @user, alert: "Could not unfollow user"
      end
    end
end