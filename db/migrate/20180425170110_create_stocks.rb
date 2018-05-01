class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :category
      t.string :sector
      t.string :industry
      t.float :price
      t.float :pe_ratio
      t.float :six_month_appreciation
      t.float :market_cap

      t.timestamps null: false
    end
  end
end
