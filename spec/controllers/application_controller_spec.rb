require 'spec_helper'

describe ApplicationController do
  controller do
    before_filter :authenticate_admin!
    def index
      render json: { message: 'Authorized' }
    end
  end

  let(:admin) { create(:administrator) }
  let(:token) { JwtService.encode(admin_id: admin.id, exp: 12.hours.from_now.to_i) }

  before do
    request.env['Authorization'] = "Bearer #{token}"
  end

  describe 'when authorized' do
    it 'allows access with valid JWT' do
      get :index
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message']).to eq('Authorized')
    end
  end
end
