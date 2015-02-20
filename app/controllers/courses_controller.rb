class CoursesController < ApplicationController
  before_action :require_user, only: [:new, :create, :add_course_status]
  
  def index
    @courses =  Course.all
  end
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.create(course_params)    
    if @course.save
      usercourse = UserCourse.new(user_id: current_user.id, course_id: @course.id, course_creator: true)
      usercourse.save
      flash[:success] = "Course created."
      redirect_to course_path(@course)
    else
      flash[:danger] = "Course not created."
      render :new
    end
  end
  
  def show
    @course = Course.find_by slug: params[:id]
    if @course == nil
      redirect_to root_path
    else
      @reviews = @course.reviews
      @review = Review.new  
    end
  end
    
  def add_course_status
    @course = Course.find_by slug: params[:course_id]
      mystatus = params[:status]
      if find_usercourse
        find_usercourse.update_column(:status, mystatus)
        find_usercourse.save
      else  
        usercourse = UserCourse.new(user_id: current_user.id, course: @course, status: mystatus)    
        usercourse.save
      end
    flash[:success] = "You have added a completed course to your profile."
    redirect_to root_path
  end
  
  def study_hall
    @course = Course.find_by slug: params[:id]
    if @course == nil
      redirect_to root_path
    else
      @posts = @course.posts
      @post = Post.new  
    end
  end
  
  private
    
  def find_usercourse
    usercourse = UserCourse.where(user_id: current_user.id, course: @course).first
  end

  def course_params
    params.require(:course).permit(:name, :provider)
  end
    
end  