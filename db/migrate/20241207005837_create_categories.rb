class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end

    add_index :categories, :created_by_id
    add_index :categories, :updated_by_id
  end
end
