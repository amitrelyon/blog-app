class RepliesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.new(reply_params)
    @reply = current_user
    @reply.post = @post
    @reply.comment = @comment
    @reply.save
    redirect_to post_path(@post)
  end

  def destroy
    @post = Reply.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.find(params[:id])
    @reply.destroy
    redirect_to post_path(@post)
  end

  private
    def reply_params
      params.require(:comment).permit(:reply_message)
    end
end
