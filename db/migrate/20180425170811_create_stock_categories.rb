class CreateStockCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :stock_categories do |t|
      t.integer :stock_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
