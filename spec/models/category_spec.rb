require 'spec_helper'

describe Category do
  it { should validate_presence_of(:name) }

  it { should belong_to(:creator).class_name('Administrator').with_foreign_key(:created_by_id) }
  it { should belong_to(:updater).class_name('Administrator').with_foreign_key(:updated_by_id) }

  it 'should create an audit log when created' do
    admin = create(:administrator)
    Current.admin_id = admin.id
    create(:category, created_by_id: admin.id, updated_by_id: admin.id)
    expect(AuditLog.last.change_data).to include("Created Category with attributes")
  end
end
