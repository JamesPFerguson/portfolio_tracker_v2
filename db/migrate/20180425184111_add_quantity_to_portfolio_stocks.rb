class AddQuantityToPortfolioStocks < ActiveRecord::Migration
  def change
    add_column :portfolio_stocks, :quantity, :integer
  end
end
