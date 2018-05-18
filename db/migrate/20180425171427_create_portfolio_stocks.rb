class CreatePortfolioStocks < ActiveRecord::Migration
  def change
    create_table :portfolio_stocks do |t|
      t.integer :stock_id
      t.integer :portfolio_id
      t.string :ticker

      t.timestamps null: false
    end
  end
end
