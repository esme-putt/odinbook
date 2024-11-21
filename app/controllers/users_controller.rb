class UsersController < ApplicationController
    before_action :authenticate_user!
  
    # GET /users or /users.json
    def index
      @users = User.all
    end
  
    # GET /posts/1 or /posts/1.json
    def show
        @user = User.find(params[:id])
    end
  
    # GET /posts/new
    def new
      @user = User.new
    end
  
    # GET /posts/1/edit
    def edit
    end
  
    # POST /posts or /posts.json
    def create
        # NOP
    end
  
    def update
    end

    def add_follower
        current_user.following.append(params[:id])
        User.find(params[:id]).followers.append(current_user.id)
    end
  
    # DELETE /posts/1 or /posts/1.json
    def destroy
      # NOP
    end
  
    private
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:content)
      end
  end