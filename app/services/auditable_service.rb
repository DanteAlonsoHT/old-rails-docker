module AuditableService
  extend ActiveSupport::Concern

  included do
    after_create :log_create
    after_update :log_update
    after_destroy :log_destroy
  end

  module ClassMethods
    def audit_enabled
      @audit_enabled = true if @audit_enabled.nil?
      @audit_enabled
    end

    def audit_enabled=(value)
      @audit_enabled = value
    end

    def audit_enabled?
      audit_enabled
    end
  end

  private

  def audit_enabled?
    self.class.audit_enabled
  end

  private

  def log_create
    return unless audit_enabled?

    raise "Current admin_id is not set" unless Current.admin_id

    AuditLog.create!(
      auditable_type: self.class.name,
      auditable_id: self.id,
      administrator_id: Current.admin_id,
      change_data: "Created #{self.class.name} with attributes: #{attributes.to_json}"
    )
  end

  def log_update
    return unless audit_enabled?

    changes_made = previous_changes.except(:updated_at)
    return if changes_made.empty?

    AuditLog.create!(
      auditable_type: self.class.name,
      auditable_id: self.id,
      administrator_id: Current.admin_id,
      change_data: "Updated #{self.class.name} with changes: #{changes_made.to_json}"
    )
  end

  def log_destroy
    return unless audit_enabled?

    AuditLog.create!(
      auditable_type: self.class.name,
      auditable_id: self.id,
      administrator_id: Current.admin_id,
      change_data: "Deleted #{self.class.name} with attributes: #{attributes.to_json}"
    )
  end
end
