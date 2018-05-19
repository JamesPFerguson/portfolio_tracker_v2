class PortfolioStocksController < ApplicationController

  def new
    @portfolio_stock = PortfolioStock.new(portfolio_id: params[:portfolio_id])
    @cheapest_stock = Stock.cheapest_stock
    @highest_mcap_value_stock = Stock.highest_mcap_value_stock
  end

  def create
    @portfolio_stock = PortfolioStock.new(portfolio_stock_params)
    stock = Scraper.scrape_ticker(params[:portfolio_stock][:ticker])
    stock.ticker = stock.ticker.upcase
    stock.save
    @portfolio_stock.stock_id = stock.id

    if @portfolio_stock.save
      redirect_to portfolio_path(current_user.portfolio)
    else
      render 'new'
    end
  end

  def edit
    @portfolio_stock = PortfolioStock.find_by(id: params[:id])
  end

  def update
      set_portfolio_stock
      @portfolio_stock.quantity = portfolio_stock_params[:quantity].to_i

      if @portfolio_stock.save
        redirect_to portfolio_path(params[:portfolio_id])
      return
    else
      byebug
      render "edit"
    end

  end


  def destroy
    PortfolioStock.find(params[:id]).destroy
    redirect_to portfolio_path(current_user.portfolio)
  end

  def set_portfolio_stock
    @portfolio_stock = PortfolioStock.find_by(id: params[:id])
  end

  def portfolio_stock_params
    params.require(:portfolio_stock).permit(:quantity, :ticker, :portfolio_id)
  end

  def verify_portfolio_stock_existence
    if !@portfolio_stock
      redirect_to "static#missing"
    end
  end

end
