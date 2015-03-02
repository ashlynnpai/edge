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
  
  def edit
    @review = Review.find(params[:id])
    @course = @review.course
    require_same_user
  end
  
  def update   
    @review = Review.find(params[:id])
    @course = @review.course
    require_same_user
  
    if @review.update(params.require(:review).permit(:content, :enrollment))
      flash[:success] = "The review was updated"
      redirect_to course_path(@course)
    else
      render :edit
    end
  end
  
  private
  
  def require_same_user
    redirect_to course_path(@course) unless logged_in? and (current_user == @review.creator)
  end
  
  
end