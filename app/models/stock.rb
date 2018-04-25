class Stock < ActiveRecord::Base
  has_many :categories, through: :stock_category
  has_many :stock_categories
  has_many :portfolios, through: :portfolio_stocks
end
