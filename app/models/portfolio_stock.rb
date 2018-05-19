class PortfolioStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
  validates :ticker, uniqueness: true
end
