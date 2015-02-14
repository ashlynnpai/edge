class CategoriesController < ApplicationController
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.create(params.require(:category).permit(:name))    
    if @category.save
      flash[:success] = "Category created."
      redirect_to root_path
    else
      flash[:danger] = "Category not created."
      render :new
    end
  end
  
end

#   def course_params
#     params.require(:course).permit(:name, :provider)
#   end