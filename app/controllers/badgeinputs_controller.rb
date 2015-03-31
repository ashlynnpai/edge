class BadgeinputsController < ApplicationController
  before_action :require_user
  
  def new
    @badgeinput = Badgeinput.new
  end
  
  def create
    @badgeinput = Badgeinput.new(badgeinput_params)
    if @badgeinput.save
      flash[:success] = "Profile saved."
      redirect_to root_path
    else
      flash[:danger] = "Profile not saved."
      render :new
    end
  end
  
  def show
    @badgeinput = Badgeinput.find(params[:id])
    require_same_user
  end
  
  private 
  
  def badgeinput_params
    params.require(:badgeinput).permit(:treehouse_name, :codeschool_name, :codewars_name, :github_name)
  end
  
  def require_same_user
    redirect_to root_path unless logged_in? and (current_user == @badgeinput.creator)
  end
end

  
