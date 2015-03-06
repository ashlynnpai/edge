class PostsController < ApplicationController
  before_action :require_user, only: [:create]
  
  def create
    @course = Course.find_by slug: params[:course_id]
    @post = @course.posts.build(params.require(:post).permit(:content, :title))
    @post.creator = current_user
    if @post.save
      flash[:success] = "Thank you for your post."
      redirect_to study_hall_path(@course)
    else
      @posts = @course.posts.reload
      render 'courses/study_hall'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @replies = @post.replies
    @reply = Reply.new  
  end
  
  def edit
    @post = Post.find(params[:id])
    @course = @post.course
    require_same_user
  end
  
  private
  
  def require_same_user
    redirect_to course_path(@course) unless logged_in? and (current_user == @post.creator)
  end
end