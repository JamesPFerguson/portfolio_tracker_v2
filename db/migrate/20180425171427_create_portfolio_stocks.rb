class CreatePortfolioStocks < ActiveRecord::Migration[4.2]
  def change
    create_table :portfolio_stocks do |t|
      t.integer :stock_id
      t.integer :portfolio_id

      t.timestamps null: false
    end
  end
end
