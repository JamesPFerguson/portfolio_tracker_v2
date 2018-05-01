require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper


  def scrape_ticker(ticker)

    stock = Stock.new(ticker: "#{ticker}")

    stock_info = Nokogiri::HTML(open("https://finviz.com/quote.ashx?t=#{ticker}"))

    stock_info.css(".snapshot-table2").each do |td|
      i = 0
      td.css(".snapshot-td2").each do |cell|
        cell.text
        case i
        when 1
          stock.pe_ratio = cell.text
        when 6
          if cell.text.include?("B")
            stock.market_cap = 1000000000 * market_cap_to_number(cell.text)
          else
            stock.market_cap = 1000000 * market_cap_to_number(cell.text)
          end
        when 23


        end #ends the case
      end #ends the second each statement
    end #ends the first each statement


  end #ends the scrape method


  def market_cap_to_number(cap)
    cap.chop.to_f
  end
end
