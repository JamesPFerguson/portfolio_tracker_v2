class Portfolio < ActiveRecord::Base
  has_many :stocks, through: :portfolio_stock
  belongs_to :user
end
