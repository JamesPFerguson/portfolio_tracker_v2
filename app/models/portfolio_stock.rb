class PortfolioStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
  accepts_nested_attributes_for :stock

  validates :quantity, :numericality => { :greater_than_or_equal_to => 1 }
  validates :ticker, uniqueness: true
  validate :ticker_exists?


  def ticker_exists?
    if Scraper.scrape_ticker(self.ticker) == nil
      errors.add(:ticker, "Ticker not found")
    end
  end

end
