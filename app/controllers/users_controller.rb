require 'digest'
require 'uri'

class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update ]     
    before_action :authenticate_user!
  
    def index
      @users = User.all
    end

    def edit
    end
  
    def show
    end

    def update
        respond_to do |format|
        if @user.update(user_params)
            format.html { redirect_to @user, notice: "User profile was successfully updated." }
            format.json { render :show, status: :ok, location: @user }
        else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        end
    end
  
    def add_follower
        current_user.following.append(params[:id])
        User.find(params[:id]).followers.append(current_user.id)
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def user_params
            params.require(:user).permit(:name, :email)
        end
  end