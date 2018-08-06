class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit]
  before_action :validate_existence, only: [:show, :edit]

  def index
    @stocks = Stock.all
    respond_to do |format|
      format.html {render 'index'}
      format.json {render json: @stocks}
    end
  end

  # def new
  #   @stock = Stock.new
  # end

  # def create
  #   ticker = params[:stock][:ticker]
  #   @stock = Scraper.scrape_ticker(ticker)
  #   @stock.save
  #
  #   PortfolioStock.create(stock_id: @stock.id, portfolio_id: current_user.portfolio.id)
  #
  #   redirect_to stock_path(@stock)
  # end

  def show
    @stock = set_stock
  end

  # def edit
  #
  # end
  #
  # def update
  #   @stock = Stock.find_by(id: params[:stock][:id])
  #   Scraper.update_stock(@stock)
  #   redirect_to stock_path(@stock)
  # end

  # def destroy
  #   @stock = Stock.find_by(id: params[:stock][:id])
  #   @stock.delete
  # end

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
