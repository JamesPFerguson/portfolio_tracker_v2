class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :password_digest
      t.integer :portfolio_id
      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
