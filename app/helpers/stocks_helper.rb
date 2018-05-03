module StocksHelper

  def stock_owned
    current_user.portfolio.stocks.include?(@stock)
  end

end
