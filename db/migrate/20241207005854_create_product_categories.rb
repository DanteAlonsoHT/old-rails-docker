class CreateProductCategories < ActiveRecord::Migration
  def self.up
    create_table :product_categories do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end

    add_index :product_categories, [:product_id, :category_id], unique: true
  end
end
