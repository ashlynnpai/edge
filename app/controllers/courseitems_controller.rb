class CourseitemsController < ApplicationController
  before_filter :require_user
  
  def create
    @course = Course.find_by slug: params[:course_id]
    #require 'pry'; binding.pry
    Courseitem.create(course: @course, user: current_user, position: 1) unless current_user.courseitems.map(&:course).include?(@course)
    redirect_to root_path
  end
end
