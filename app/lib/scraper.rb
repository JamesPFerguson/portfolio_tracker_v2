require 'nokogiri'
require 'open-uri'
require 'pry'
require 'net/http'
require 'json'

class Scraper

  #https://api.iextrading.com/1.0/stock








  def self.scrape_ticker(ticker)
    byebug

    url = 'https://api.iextrading.com/1.0/stock' + "/" + ticker
    stats = '/stats'
    quote = '/quote'

    uri = URI(url + stats)
    response = Net::HTTP.get(uri)
    json_stock = JSON.parse(response)

    uri = URI(url + quote)
    response = Net::HTTP.get(uri)
    json_stock_quote = JSON.parse(response)

    #
    # Categories to be assigned to a stock after scraping
    #
    value_id = Category.find_by(name: "Value")
    momentum_id = Category.find_by(name: "Momentum")
    neutral_id = Category.find_by(name: "Neutral")

    # Marketwatch is used to obtain the company name via the ticker
    # stock_info uses finviz to pull specific data about the stock
    #
    marketwatch = Nokogiri::HTML(open("https://www.marketwatch.com/investing/stock/#{ticker}"))
    stock_info = Nokogiri::HTML(open("https://finviz.com/quote.ashx?t=#{ticker}"))

    # The stock is instantiated and then assigned a ticker and name
    stock = Stock.new(ticker: ticker.upcase)
    stock.name = marketwatch.css(".company__name").text

    # This loop goes through each element in the
    # finviz table and pulls the relevant info
    #
    stock_info.css(".snapshot-table2").each do |td|
      i = 0 #iterates through each cell in the table
      td.css(".snapshot-td2").each do |cell|
        case i
        when 1
          stock.pe_ratio = cell.text.to_f
        when 6
          stock.market_cap_string = (cell.text)
          if cell.text.include?("B")
            stock.market_cap = 1000000000 * market_cap_to_number(cell.text)
          else
            stock.market_cap = 1000000 * market_cap_to_number(cell.text)
          end
        when 23
          stock.six_month_appreciation = cell.text.to_f
        when 65
          stock.price = cell.text.to_f
        end #ends the case
        i += 1 #iterates through the table
      end #ends the second each statement
    end #ends the first each statement

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
