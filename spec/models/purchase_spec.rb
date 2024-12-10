require 'spec_helper'

describe Purchase do
  it { should validate_presence_of(:product_id) }
  it { should validate_presence_of(:customer_id) }
  it { should validate_presence_of(:price_at_sale) }
  it { should validate_numericality_of(:price_at_sale).is_greater_than(0) }

  it { should belong_to(:product) }
  it { should belong_to(:customer) }
end
