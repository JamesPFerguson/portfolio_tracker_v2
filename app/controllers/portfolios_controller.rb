class PortfoliosController < ApplicationController

  def show
    set_portfolio
    @portfolio_stocks = @portfolio.portfolio_stocks
  end

  def update
    set_portfolio
    @portfolio.stocks.each do |stock|
      @stock = Stock.find_by(ticker: stock.ticker)
      stock2 = Scraper.scrape_ticker(stock.ticker)
      stock2.attributes.each do | att, value |
        @stock.send("#{att}=", value)
      end
      @stock.save
      redirect_to portfolio_path(@portfolio)
  end

  def set_portfolio
    @portfolio = Portfolio.find_by(id: params[:id])
  end

end
