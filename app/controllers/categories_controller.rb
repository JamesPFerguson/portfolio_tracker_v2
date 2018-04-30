class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def create
    category = category.new(category_params)
    if category.save
      redirect_to categories_path
    else
      render 'create'
    end
  end

  def edit

  end

  def update

  end

  def delete
    if category = Category.find_by(id: params[:category][:id])
      category.delete
      redirect_to categories_path
    else
      redirect_to categories_path
    end
  end

end
