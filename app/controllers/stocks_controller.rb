class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]
  before_action :validate_existence, only: [:show, :edit, :update, :destroy]

  def index
    @stocks = Stock.all
  end

  def new
    @stock = Stock.new
  end

  def create
    ticker = params[:stock][:ticker]
    scraper = Scraper.new
    @stock = scraper.scrape_ticker(ticker)
    current_user.stocks << @stock
    redirect_to stocks_path
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def stock_params
    params.require(:stock).permit(:ticker)
  end

  def set_stock
    @stock = Stock.find_by(id: params[:id])
  end

  def validate_existence
    if !@stock
      redirect_to static_missing_path
    end
  end


end
