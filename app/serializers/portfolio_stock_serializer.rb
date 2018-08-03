class PortfolioStockSerializer < ActiveModel::Serializer
  attributes :id, :stock_id, :portfolio_id, :quantity
end
