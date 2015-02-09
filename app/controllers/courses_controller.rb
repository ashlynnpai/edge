class CoursesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.create(course_params)  
    
    if @course.save
      @usercourse = UserCourse.create
      @usercourse.course_id = @course.id
      @usercourse.user_id = current_user.id
      @usercourse.course_creator = true
      flash[:success] = "Course created."
      redirect_to course_path(@course)
    else
      flash[:danger] = "Course not created."
      render :new
    end
  end
  
  def show
    @course = Course.find_by slug: params[:id]
  end
  
  private

  def course_params
    params.require(:course).permit(:name, :provider)
  end
    
end  