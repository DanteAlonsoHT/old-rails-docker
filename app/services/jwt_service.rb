class JwtService
  def self.encode(payload)
    JWT.encode(payload, JWT_SECRET, 'HS256')
  end

  def self.decode(token)
    body, = JWT.decode(token, JWT_SECRET, true, { algorithm: 'HS256' })
    body
  rescue JWT::DecodeError
    nil
  end
end
