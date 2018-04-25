class Portfolio < ActiveRecord::Base
  has_many :stocks, through: :portfolio_stock
end
