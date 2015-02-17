class ReviewsController < ApplicationController
  before_action :require_user
  
  def create
    @course = Course.find_by slug: params[:course_id]
    @review = @course.reviews.build(params.require(:review).permit(:content, :enrollment))
    @review.creator = current_user
    if @review.save
      flash[:success] = "Thank you for your review."
      redirect_to course_path(@course)
    else
      @reviews = @course.reviews.reload
      render 'courses/show'
    end
  end
  
  
end