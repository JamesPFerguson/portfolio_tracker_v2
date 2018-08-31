class AddTickerToPortfolioStocks < ActiveRecord::Migration[4.2]
  def change
    add_column :portfolio_stocks, :ticker, :string
  end
end
