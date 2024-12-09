class AuditLog < ActiveRecord::Base
  attr_accessible :auditable_type, :auditable_id, :administrator_id, :change_data

  belongs_to :auditable, polymorphic: true
  belongs_to :administrator

  validates :auditable_type, :auditable_id, :administrator_id, presence: true
  validates :change_data, length: { maximum: 5000 }
end
