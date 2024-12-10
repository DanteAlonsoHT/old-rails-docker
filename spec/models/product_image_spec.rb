require 'spec_helper'

describe ProductImage do
  it { should validate_presence_of(:image_url) }
  it { should belong_to(:product) }
end
