require 'spec_helper'

describe ProductCategory do
  it { should belong_to(:product) }
  it { should belong_to(:category) }
  it { should validate_uniqueness_of(:product_id).scoped_to(:category_id) }
end
