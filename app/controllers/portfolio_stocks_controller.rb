class PortfolioStocksController < ApplicationController

  def new
    @portfolio_stock = PortfolioStock.new
    @cheapest_stock = Stock.cheapest_stock
    @highest_mcap_value_stock = Stock.highest_mcap_value_stock
  end

  def create
    @portfolio_stock = PortfolioStock.new(portfolio_stock_params)
    if @portfolio_stock.save
      redirect_to portfolio_path(current_user.portfolio)
    else
      render 'new'
    end
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

end
