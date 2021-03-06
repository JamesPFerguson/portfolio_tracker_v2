class PortfoliosController < ApplicationController

  def show
    set_portfolio
    @portfolio_stocks = @portfolio.portfolio_stocks
    respond_to do |format|
      format.html {render 'show'}
      format.json {render json: @portfolio}
    end
  end

  def update
    @portfolio = user_portfolio_id
    Scraper.update_all(@portfolio.stocks)
    redirect_to portfolio_path(@portfolio)
  end

  def set_portfolio
    @portfolio = Portfolio.find_by(id: params[:id])
  end

  def set_portfolio_and_stocks
    set_portfolio
    @portfolio_stocks = @portfolio.portfolio_stocks
  end

  def map_stocks
    set_portfolio_and_stocks
    @stock_ids = []
    @portfolio_stocks.each do |stock|
      @stock_ids << stock.id
    end

  end


end
