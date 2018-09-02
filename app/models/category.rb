class Category < ActiveRecord::Base
  has_many :stock_categories
  has_many :stocks, through: :stock_categories

  validates :name, uniqueness: true
  validates :name, presence: true
end
