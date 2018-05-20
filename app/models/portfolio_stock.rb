class PortfolioStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
  accepts_nested_attributes_for :stock

  def upcased_ticker
    self.ticker.upcase
  end
end
