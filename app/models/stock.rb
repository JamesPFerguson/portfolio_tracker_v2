class Stock < ActiveRecord::Base
  has_many :categories, through: :stock_category
  has_many :stock_categories
  has_many :portfolios, through: :portfolio_stocks

  def self.cheapest_stock
    byebug
    where("pe_ratio > 0").order("pe_ratio asc").first
  end

  def self.highest_momentum_value_stock
    where("category = value").order("six_month_appreciation desc").first
  end
end
