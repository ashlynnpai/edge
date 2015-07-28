class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
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
  
  def points
    @user = User.find_by slug: params[:id]
  end    
  
  def make_private
    @user = current_user
    if current_user
    # validations won't block user update
      if @user.update_attribute(:public_profile, false)
        flash[:success] = "Profile set to private."
      else
        flash[:danger] = "Profile has not been changed."
      end
      redirect_to dashboard_path
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
  
end