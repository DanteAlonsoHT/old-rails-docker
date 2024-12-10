require 'spec_helper'

describe AuditableService do
  let(:admin) { create(:administrator) }

  before do
    Current.admin_id = admin.id
  end

  after do
    Current.reset
    AuditableTestModel.audit_enabled = true
  end

  describe 'audit_enabled toggle' do
    it 'allows enabling and disabling auditing dynamically' do
      AuditableTestModel.audit_enabled = true
      expect(AuditableTestModel.audit_enabled?).to eq(true)

      AuditableTestModel.audit_enabled = false
      expect(AuditableTestModel.audit_enabled?).to eq(false)
    end
  end

  context 'when audit is disabled' do
    before do
      AuditableTestModel.audit_enabled = false
    end

    it 'does not log creation of a record' do
      expect {
        AuditableTestModel.create!(name: 'Test Category', created_by_id: admin.id, updated_by_id: admin.id)
      }.not_to change { AuditLog.count }
    end
  end
end
