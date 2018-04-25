class Category < ActiveRecord::Base
  has_many :stocks, through: :stock_categories
end
