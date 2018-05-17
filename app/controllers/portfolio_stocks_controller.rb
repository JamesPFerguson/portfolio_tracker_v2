class PortfolioStocksController < ApplicationController

  def new
    @portfolio_stock = PortfolioStock.create(portfolio_stock_params)

  end

  def edit

  end

  def portfolio_stock_params
    params.require(:portfolio_stock).permit(:quantity, :ticker)
end
