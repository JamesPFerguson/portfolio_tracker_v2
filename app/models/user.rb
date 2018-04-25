class User < ActiveRecord::Base
  has_many :stocks, through: :portfolio
end
