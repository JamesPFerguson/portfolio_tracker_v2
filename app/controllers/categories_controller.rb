class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def create
    category = Category.new(category_params)
    if category.save
      redirect_to category_path(category)
    else
      render 'create'
    end
  end

  def show
    @category = Category.find_by(id: params[:id])
  end

  def edit
    @category = Category.find_by(id: params[:id])
  end

  def update
    category = Category.find_by(id: params[:id])
    category.update(category_params)
    redirect_to category_path(category)
  end

  def delete
    if category = Category.find_by(id: params[:category][:id])
      category.delete
      redirect_to categories_path
    else
      redirect_to categories_path
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
