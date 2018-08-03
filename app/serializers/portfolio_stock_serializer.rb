class PortfolioStockSerializer < ActiveModel::Serializer
  attributes :ticker, :stock_id, :portfolio_id :quantity
end
