class StockSerializer < ActiveModel::Serializer
  attributes
    :id,
    :name,
    :industry,
    :market_cap_string,
    :price,
    :pe_ratio,
    :six_month_appreciation
end
