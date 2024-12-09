class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
      t.integer :product_id
      t.integer :customer_id
      t.decimal :price_at_sale, precision: 10, scale: 2
      t.datetime :purchased_at

      t.timestamps
    end

    add_index :purchases, :product_id
    add_index :purchases, :customer_id
    add_index :purchases, :purchased_at
  end
end
