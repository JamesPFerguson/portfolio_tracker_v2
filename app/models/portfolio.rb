class Portfolio < ActiveRecord::Base
  has_many :stocks, through: :portfolio_stocks
  has_many :portfolio_stocks
  belongs_to :user


  def value
    p_value = 0
    self.portfolio_stocks.each do |p_stock|
        p_value += p_stock.quantity * Stock.find(p_stock.stock_id).price
    end
    p_value
  end

end
