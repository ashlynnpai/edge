class CoursesController < ApplicationController
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.create(course_params)
    if @course.save
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