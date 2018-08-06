class StockSerializer < ActiveModel::Serializer
  attributes :id,:name,:sector, :market_cap_string,
  :price,:pe_ratio,:six_month_appreciation,:ticker
end
