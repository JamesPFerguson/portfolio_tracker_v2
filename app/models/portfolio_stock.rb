class PortfolioStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
  accepts_nested_attributes_for :stock

  validates :quantity, :numericality => { :greater_than_or_equal_to => 1 }
  validate :ticker_exists?


  def ticker_exists?
    if self.ticker == nil || !Scraper.valid_ticker?(self.ticker)
      errors.add(:ticker, "Ticker not found")
    end
  end

end
