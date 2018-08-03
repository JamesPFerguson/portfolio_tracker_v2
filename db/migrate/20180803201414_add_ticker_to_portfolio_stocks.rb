class AddTickerToPortfolioStocks < ActiveRecord::Migration
  def change
    add column :portfolio_stocks, :ticker, :string
  end
end
