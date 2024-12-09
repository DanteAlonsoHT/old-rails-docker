class CreateAuditLogs < ActiveRecord::Migration
  def self.up
    create_table :audit_logs do |t|
      t.string :auditable_type
      t.integer :auditable_id
      t.integer :administrator_id
      t.text :change_data

      t.timestamps
    end

    add_index :audit_logs, [:auditable_type, :auditable_id]
    add_index :audit_logs, :administrator_id
  end
end
