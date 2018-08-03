class PortfolioSerializer < ActiveModel::Serializer
  attributes  :id, :value
  has_many :stocks, through: :portfolio_stocks
  has_many :portfolio_stocks
end
