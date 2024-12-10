require 'spec_helper'

describe Api::PurchasesController do
  let(:admin) { create(:administrator) }
  let(:customer) { create(:customer) }
  let(:category) { create(:category, created_by: admin, updated_by: admin) }
  let(:product) { create(:product, categories: [category], created_by: admin, updated_by: admin) }
  let!(:purchases) { create_list(:purchase, 3, product: product, customer: customer) }
  let(:token) { JwtService.encode(admin_id: admin.id, exp: 12.hours.from_now.to_i) }

  before do
    request.env['Authorization'] = "Bearer #{token}"
    Current.admin_id = admin.id
  end

  after do
    Current.reset
  end

  describe 'GET #index' do
    it 'returns purchases with valid filters' do
      get :index, { from: 1.day.ago.to_date, to: Time.now.to_date }
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      expect(data).to be_an(Array)
    end
  end
end
