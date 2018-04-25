class StockCategory < ActiveRecord::Base
  belongs_to :stock
  belongs_to :category
end
