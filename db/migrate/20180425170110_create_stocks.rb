class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.String :name
      t.float :price
      t.float :pe_ratio

      t.timestamps null: false
    end
  end
end
