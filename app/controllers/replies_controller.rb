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
      render 'posts/show'
    end
  end
  
  def edit
    @reply = Reply.find(params[:id])
    @post = @reply.post
    require_same_user
  end
  
  private
  
  def require_same_user
    redirect_to post_path(@post) unless logged_in? and (current_user == @reply.creator)
  end
end