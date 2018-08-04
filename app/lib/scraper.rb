require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'

class Scraper

  #https://api.iextrading.com/1.0/stock

  value_id = Category.find_by(name: "Value")
  momentum_id = Category.find_by(name: "Momentum")
  neutral_id = Category.find_by(name: "Neutral")

  def self.scrape_ticker(ticker)

    url = 'https://api.iextrading.com/1.0/stock' + "/" + ticker
    stats = '/stats'
    quote = '/quote'

    uri = URI(url + stats)
    response = Net::HTTP.get(uri)
    json_stock = JSON.parse(response)

    uri = URI(url + quote)
    response = Net::HTTP.get(uri)
    json_stock_quote = JSON.parse(response)

    stock = Stock.new(ticker: ticker.upcase)
    stock.name = json_stock["companyName"]
    stock.sector = json_stock_quote["sector"]
    stock.price = json_stock_quote["latestPrice"].to_f
    stock.pe_ratio = json_stock_quote["peRatio"].to_f
    stock.market_cap = json_stock_quote["marketCap"]).to_f
    stock.six_month_appreciation = json_stock[]"month6ChangePercent"].to_f
    stock.make_cap_string
    stock.save

    if stock.pe_ratio < 18 && stock.six_month_appreciation > 15
      StockCategory.create(stock_id: stock.id, category_id: value_id)
      StockCategory.create(stock_id: stock.id, category_id: momentum_id)
    elsif stock.six_month_appreciation > 15
      StockCategory.create(stock_id: stock.id, category_id: momentum_id)
    elsif stock.pe_ratio < 18
      StockCategory.create(stock_id: stock.id, category_id: value_id)
    else
      StockCategory.create(stock_id: stock.id, category_id: neutral_id)
    end

      return stock
  end #ends the scrape method


  def self.market_cap_to_number(cap)
    cap.chop.to_f
  end

  def self.update_stock(stock)
    @stock = Stock.find_by(ticker: stock.ticker)
    stock2 = Scraper.scrape_ticker(stock.ticker)
    stock2.attributes.each do | att, value |
      @stock.send("#{att}=", value)
    end
  end


  def self.update_all(stocks)
    stocks.each do |stock|
      self.update_stock(stock)
    end
  end

end
