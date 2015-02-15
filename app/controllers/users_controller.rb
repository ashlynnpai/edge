class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    @user = User.find_by slug: params[:id]
  end
  
  def transcript
    @user = User.find_by slug: params[:id]
  end
    
  
  private
  
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
  
end