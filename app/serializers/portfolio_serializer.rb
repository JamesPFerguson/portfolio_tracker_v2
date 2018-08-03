class PortfolioSerializer < ActiveModel::Serializer
  attributes  :id, :value
  has_many :portfolio_stocks
end
