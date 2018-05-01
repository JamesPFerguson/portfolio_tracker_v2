class StocksController < ApplicationController

  def index
    @stocks = user.stocks
  end

  def new

  end

  def create

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def set_category
    @stock = Stock.find_by(id: params[:id])
  end

  def validate_existence
    if !@stock
      redirect_to static_missing_path
    end
  end


end
