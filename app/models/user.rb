class User < ActiveRecord::Base
  has_secure_password
  has_many :stocks, through: :portfolio
  has_one :portfolio

end
