class PortfolioStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
  validates :ticker, uniqueness: true

  def upcased_ticker
    self.ticker.upcase
  end
end
