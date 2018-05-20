class PortfolioStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio

  def upcased_ticker
    self.ticker.upcase
  end
end
