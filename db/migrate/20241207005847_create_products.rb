class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :products, :created_by_id
    add_index :products, :updated_by_id
    add_index :products, :name
  end
end
