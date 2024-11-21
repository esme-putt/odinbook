class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @users = User.all
    end
  
    def show
        @user = User.find(params[:id])
    end
  
    def add_follower
        current_user.following.append(params[:id])
        User.find(params[:id]).followers.append(current_user.id)
    end
  end