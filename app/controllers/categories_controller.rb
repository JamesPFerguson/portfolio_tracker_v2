class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    category.update(category_params)
    redirect_to category_path(category)
  end

  def delete
    if set_category
      category.delete
      redirect_to categories_path
    else
      redirect_to categories_path
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def destroy
    @category.delete
  end


  def set_category
    @category = Category.find_by(id: params[:id])
  end

end
