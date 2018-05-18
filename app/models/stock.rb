class Stock < ActiveRecord::Base
  has_many :categories, through: :stock_category
  has_many :stock_categories
  has_many :portfolios, through: :portfolio_stocks
  belongs_to :category

  def self.cheapest_stock
    where("pe_ratio > 0").order("pe_ratio asc").first
  end

  # def self.highest_momentum_value_stock
  #   where("category_id = ?", Category.find_by(name: "Value").id).order("six_month_appreciation desc").first
  # end

  def self.highest_mcap_value
    where("pe_ratio > 0").order("market_cap desc").first
  end


end
