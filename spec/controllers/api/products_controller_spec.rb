require 'spec_helper'

describe Api::ProductsController do
  let(:admin) { create(:administrator) }
  let(:token) { JwtService.encode(admin_id: admin.id, exp: 12.hours.from_now.to_i) }

  before do
    request.env['Authorization'] = "Bearer #{token}"
    Current.admin_id = admin.id
  end

  after do
    Current.reset
  end

  let!(:categories) do
    create_list(:category, 2, created_by: admin, updated_by: admin).each do |category|
      create_list(:product, 3, categories: [category], created_by: admin, updated_by: admin)
    end
  end

  describe 'GET #most_purchased_by_category' do
    it 'returns products grouped by category when authenticated' do
      get :most_purchased_by_category
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      expect(data).to be_an(Array)
    end
  end
end
