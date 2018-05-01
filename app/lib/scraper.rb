class Scraper


  def scrape_ticker(ticker)
    stock = Nokogiri::HTML(open("https://finviz.com/quote.ashx?t=#{ticker}"))

  end

end
