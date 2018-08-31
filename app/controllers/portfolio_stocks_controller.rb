class PortfolioStocksController < ApplicationController

  def new
    @portfolio_stock = PortfolioStock.new(portfolio_id: params[:portfolio_id])
    @stock = Stock.new
    @cheapest_stock = Stock.cheapest_stock
    @highest_mcap_value_stock = Stock.highest_mcap_value_stock
    @portfolio_stocks = current_user.portfolio.portfolio_stocks
  end

  def create
    @portfolio_stock = PortfolioStock.new(portfolio_stock_params)
    if stock = Stock.find_by(ticker: params_ticker)
      Scraper.update_stock(stock)
    else
      stock = Scraper.scrape_ticker(params_ticker)
    end

    @portfolio_stock.stock_id = stock.id
    @portfolio_stock.ticker = stock.ticker
    @portfolio_stock.price = stock.price


    if @portfolio_stock.save
      render json: @portfolio_stock, status: 200
    else
      render 'new'
    end

  end

  def edit
    set_portfolio_stock
  end

  def update
      set_portfolio_stock
      @portfolio_stock.quantity = portfolio_stock_params[:quantity].to_i

      if @portfolio_stock.quantity == 0
        @portfolio_stock.destroy
        redirect_to portfolio_path(params[:portfolio_id])
      elsif @portfolio_stock.save
        redirect_to portfolio_path(params[:portfolio_id])
      else
        render "edit"
      end

  end


  def destroy
    PortfolioStock.find(params[:id]).destroy
    redirect_to portfolio_path(current_user.portfolio)
  end


  def show
    # Map an array of owned stocks, render a show page which allows user to traverse
    # through the info associated with each stock they own without a page refresh.
    # @owned tells the view page to load the correct button, since we will be using
    # the stock view page rather than creating a new one.
    map_stocks
    id = stock_ids[0]
    @stock = Stock.find(id)
    @owned = true
  end

  def map_stocks
    portfolio = current_user.portfolio
    stocks = portfolio.stocks
    stock_ids = []
    portfolio_stocks.each do |stock|
      stock_ids << stock.id
    end

  end

  def expensive
    @expensive_stock = Stock.most_expensive_stock
  end

  def set_portfolio_stock
    @portfolio_stock = PortfolioStock.find_by(id: params[:id])
    @ticker = @portfolio_stock.stock.ticker
  end

  def portfolio_stock_params
    params.require(:portfolio_stock).permit(:quantity, :ticker, :portfolio_id, stock_attributes: [:ticker])
  end

  def verify_portfolio_stock_existence
    if !@portfolio_stock
      redirect_to "static#missing"
    end
  end

  def params_ticker
    params[:portfolio_stock][:stock_attributes][:ticker].upcase
  end

end
