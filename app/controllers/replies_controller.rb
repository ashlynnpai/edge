class RepliesController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(params.require(:reply).permit(:content))
    @reply.creator = current_user
    if @reply.save
      flash[:success] = "Thank you for your comment."
      redirect_to post_path(@post)
    else
      @replies = @post.replies.reload
      render 'replies/reply'
    end
  end
end