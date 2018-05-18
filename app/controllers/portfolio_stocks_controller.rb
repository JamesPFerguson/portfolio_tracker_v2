class PortfolioStocksController < ApplicationController

  def new
    @portfolio_stock = PortfolioStock.create(portfolio_stock_params)
    @cheapest_stock = Stock.cheapest_stock
    @momentum_value_stock = Stock.highest_momentum_value_stock
  end

  def edit
    @portfolio_stock = PortfolioStock.find_by(id: params[:id])
  end

  def destroy
    PortfolioStock.find(params[:id]).destroy
    redirect_to portfolio_path(current_user.portfolio)
  end

  def portfolio_stock_params
    params.require(:portfolio_stock).permit(:quantity, :ticker)
end
