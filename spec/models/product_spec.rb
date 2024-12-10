require 'spec_helper'

describe Product do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than(0) }

  it { should belong_to(:creator).class_name('Administrator').with_foreign_key(:created_by_id) }
  it { should belong_to(:updater).class_name('Administrator').with_foreign_key(:updated_by_id) }

  it { should have_many(:product_categories) }
  it { should have_many(:categories).through(:product_categories) }

  it 'should create an audit log when updated' do
    admin = create(:administrator)
    
    Current.admin_id = admin.id
    
    product = create(:product, created_by_id: admin.id, updated_by_id: admin.id)
    product.update_attributes(price: 200.0)
    
    expect(AuditLog.last.change_data).to include("Updated Product with changes")
  end
end
