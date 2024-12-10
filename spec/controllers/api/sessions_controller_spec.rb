require 'spec_helper'

describe Api::SessionsController do
  let!(:admin) { create(:administrator, email: 'admin@example.com', password: 'password') }

  describe 'POST #create' do
    it 'returns a token with valid credentials' do
      post :create, { email: 'admin@example.com', password: 'password' }
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      expect(data).to have_key('token')
    end

    it 'returns unauthorized with invalid credentials' do
      post :create, { email: 'admin@example.com', password: 'wrongpassword' }
      expect(response.status).to eq(401)
      data = JSON.parse(response.body)
      expect(data).to have_key('error')
    end
  end
end
