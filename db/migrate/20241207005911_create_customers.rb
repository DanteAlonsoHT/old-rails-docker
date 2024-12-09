class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end

    add_index :customers, :email, unique: true
  end
end
