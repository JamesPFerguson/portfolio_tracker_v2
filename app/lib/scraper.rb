require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'

class Scraper

  #https://api.iextrading.com/1.0/stock

  @@value_id = Category.find_by(name: "Value")
  @@momentum_id = Category.find_by(name: "Momentum")
  @@neutral_id = Category.find_by(name: "Neutral")

  def self.valid_ticker?(ticker)
    url = 'https://api.iextrading.com/1.0/stock' + "/" + ticker
    stats = '/stats'
    quote = '/quote'

    uri = URI(url + stats)
    response = Net::HTTP.get(uri)
    if response == "Not Found"
      return false
    else
      return true
    end

  end

  def self.scrape_ticker(ticker)

    url = 'https://api.iextrading.com/1.0/stock' + "/" + ticker
    stats = '/stats'
    quote = '/quote'

    uri = URI(url + stats)
    response = Net::HTTP.get(uri)
    if response == "Not Found"
      return stock = Stock.new
    else
      json_stock = JSON.parse(response)

      uri = URI(url + quote)
      response = Net::HTTP.get(uri)
      json_stock_quote = JSON.parse(response)

      stock = Stock.find_or_initialize_by(ticker: ticker.upcase)
      stock.name = json_stock["companyName"]
      stock.sector = json_stock_quote["sector"]
      stock.price = json_stock_quote["latestPrice"].to_f
      stock.pe_ratio = json_stock_quote["peRatio"].to_f
      stock.market_cap = json_stock_quote["marketCap"].to_f
      stock.six_month_appreciation = json_stock["month6ChangePercent"].to_f.round(4)*100
      stock.make_cap_string
      stock.save

      if stock.id

        if stock.pe_ratio < 18 && stock.six_month_appreciation > 15
          create_category_with_id(stock.id, @@value_id)
          create_category_with_id(stock.id, @@momentum_id)
        elsif stock.six_month_appreciation > 15
          create_category_with_id(stock.id, @@momentum_id)
        elsif stock.pe_ratio < 18
          create_category_with_id(stock.id, @@value_id)
        else
          create_category_with_id(stock.id, @@neutral_id)
        end

      end

        return stock
      end

  end #ends the scrape method

  # def self.update_stock(stock)
  #   @stock = Stock.find_by(ticker: stock.ticker)
  #   stock2 = Scraper.scrape_ticker(stock.ticker)
  #   stock2.attributes.each do | att, value |
  #     case att
  #       when !("id" || "name" || "sector")
  #          @stock.send("#{att}=", value)
  #       else
  #         nil
  #     end
  #   end
  #   @stock.make_cap_string
  #   @stock.save
  # end


  def self.update_all(stocks)
    stocks.each do |stock|
      self.scrape_ticker(stock.ticker)
    end
  end

  def self.create_category_with_id(stockId, categoryId)
    StockCategory.create(stock_id: stockId, category_id: categoryId)
  end


  # def self.get_parsed_stock(stick)
  #   url = 'https://api.iextrading.com/1.0/stock' + "/" + ticker
  #   stats = '/stats'
  #   quote = '/quote'

  #   uri = URI(url + stats)
  #   response = Net::HTTP.get(uri)
  #   if response == "Not Found"
  #     return stock = Stock.new
  #   else
  #     json_stock = JSON.parse(response)

  #     uri = URI(url + quote)
  #     response = Net::HTTP.get(uri)
  #     json_stock_quote = JSON.parse(response)

end
