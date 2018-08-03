class AddTickerToPortfolioStocks < ActiveRecord::Migration
  def change
    add_column :portfolio_stocks, :ticker, :string
  end
end
