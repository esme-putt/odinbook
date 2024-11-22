class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def index
    end
  
    def show
    end
  
    def edit
    end
  
    def create
        logger.debug "CREATE ACTION STARTED"  # Add this line
        logger.debug "Params: #{params.inspect}"  # Add this line

        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))
    
        respond_to do |format|
            if @comment.save
              puts "Comment saved successfully: #{@comment.inspect}" # Debug line
              format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
            else
              puts "Comment failed to save: #{@comment.errors.full_messages}" # Debug line
              format.html { redirect_to post_path(@post), alert: 'Error creating comment.' }
            end
          end
    end
  
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @post, notice: "Comment was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @comment.destroy!
  
      respond_to do |format|
        format.html { redirect_to posts_path, status: :see_other, notice: "Comment was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      def comment_params
        params.require(:comment).permit(:content)
      end
  end
  