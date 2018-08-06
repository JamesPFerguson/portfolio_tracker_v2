module PortfoliosHelper

  def price_from_portfolio_stock(stock_id)
      Stock.find(stock_id).price
  end



end
