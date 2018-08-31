class AddQuantityToPortfolioStocks < ActiveRecord::Migration[4.2]
  def change
    add_column :portfolio_stocks, :quantity, :integer
  end
end
