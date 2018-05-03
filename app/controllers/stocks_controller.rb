class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit]
  before_action :validate_existence, only: [:show, :edit]

  def index
    @stocks = Stock.all
  end

  def new
    @stock = Stock.new
  end

  def create
    ticker = params[:stock][:ticker]
    if @stock =  Stock.find_by(ticker: ticker)

    else
      @stock = Scraper.scrape_ticker(ticker)
      current_user.stocks << @stock
    end
    redirect_to stocks_path
  end

  def show

  end

  def edit

  end

  def update
    @stock = Stock.find_by(id: params[:stock][:id])
    @stock.update
  end

  def destroy
    @stock = Stock.find_by(id: params[:stock][:id])
    @stock.delete
  end

  def stock_params
    #needs to accept nested attribute for quantity
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
