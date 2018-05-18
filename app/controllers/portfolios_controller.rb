class PortfoliosController < ApplicationController

  def show
    set_portfolio
    @portfolio_stocks = @portfolio.portfolio_stocks
  end

  def update
    set_portfolio
    Scraper.update_all(@portfolio.stocks)
    redirect_to portfolio_path(@portfolio)
  end

  def set_portfolio
    @portfolio = Portfolio.find_by(id: params[:id])
  end


end
