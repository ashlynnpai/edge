class PostsController < ApplicationController
  before_action :require_user
  
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
end