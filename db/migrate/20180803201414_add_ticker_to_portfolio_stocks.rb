class AddTickerToPortfolioStocks < ActiveRecord::Migration
  def change
    add_column :portfolio_stocks, :ticker, :string
    add_column :portfolio_stocks, :price, :float
  end
end
