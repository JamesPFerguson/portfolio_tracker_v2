class User < ActiveRecord::Base
  has_secure_password
  has_many :stocks, through: :portfolio
  has_one :portfolio

  validates :name, uniqueness: true
  validates :email, uniqueness: true
end
