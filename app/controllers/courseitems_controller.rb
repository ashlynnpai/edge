class CourseitemsController < ApplicationController
  before_filter :require_user
  
  def index
    @courseitems = current_user.courseitems
  end
  
  def create
    @course = Course.find_by slug: params[:course_id]
    Courseitem.create(course: @course, user: current_user, position: last_position) unless current_user.courseitems.map(&:course).include?(@course)
    redirect_to root_path
  end
  
  private
  
  def last_position
    current_user.courseitems.count + 1
  end
  
end
