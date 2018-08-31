class CreatePortfolios < ActiveRecord::Migration[4.2]
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.integer :value

      t.timestamps null: false
    end
  end
end
