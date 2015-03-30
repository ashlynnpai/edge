class CategoriesController < ApplicationController
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params.require(:category).permit(:name))    
    if @category.save
      flash[:success] = "Category created."
      redirect_to root_path
    else
      flash[:danger] = "Category not created."
      render :new
    end
  end
  
  def show
    @category = Category.find_by slug: params[:id]
    if @category == nil
      redirect_to root_path
    end
  end

end

