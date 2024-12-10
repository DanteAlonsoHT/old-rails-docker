describe JwtService do
  let(:payload) { { admin_id: 1, exp: 1.hour.from_now.to_i } }
  let(:secret) { ENV['JWT_SECRET'] || 'Llave&D1f1c1l_^D3_1div1n4r$' }

  before do
    stub_const("JWT_SECRET", secret)
  end

  describe '.encode' do
    it 'returns a JWT token for the given payload' do
      token = JwtService.encode(payload)
      expect(token).to be_a(String)
    end
  end

  describe '.decode' do
    it 'decodes a valid JWT token' do
      token = JwtService.encode(payload)
      decoded_payload = JwtService.decode(token)
      expect(decoded_payload).to include('admin_id' => 1)
    end

    it 'returns nil for an expired token' do
      expired_payload = { admin_id: 1, exp: 1.hour.ago.to_i }
      token = JwtService.encode(expired_payload)
      expect(JwtService.decode(token)).to be_nil
    end
  end
end
