class CreateProductImages < ActiveRecord::Migration
  def self.up
    create_table :product_images do |t|
      t.integer :product_id
      t.string :image_url

      t.timestamps
    end

    add_index :product_images, :product_id
  end
end
