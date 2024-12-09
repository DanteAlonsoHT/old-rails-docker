class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :administrators do |t|
      t.string :email
      t.string :name
      t.string :password_digest

      t.timestamps
    end

    add_index :administrators, :email, unique: true
  end
end
