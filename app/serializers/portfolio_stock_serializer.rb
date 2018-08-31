class PortfolioStockSerializer < ActiveModel::Serializer
  attributes :id, :ticker, :stock_id, :portfolio_id, :quantity, :price
end
