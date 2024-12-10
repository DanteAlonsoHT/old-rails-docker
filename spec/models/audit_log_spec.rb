require 'spec_helper'

describe AuditLog do
  it { should validate_presence_of(:auditable_type) }
  it { should validate_presence_of(:auditable_id) }
  it { should validate_presence_of(:administrator_id) }
  it { should validate_presence_of(:change_data) }

  it { should belong_to(:administrator) }
end
