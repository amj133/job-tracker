class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "#{@category.title} added!"
      redirect_to categories_path
    else
      render :new
    end

    # flash.notice = "Category '#{@category.title}' Created!"

    # redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

end
