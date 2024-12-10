class Api::SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  swagger_controller :sessions, 'Authentication Management'

  swagger_config = {
    controller: 'sessions',
    description: 'Authentication Management',
    resource_path: '/sessions'
  }

  swagger_api :create do
    summary 'Generate JWT token for authentication'
    notes 'Returns a JWT token to be used for authenticate in API calls'
    param :form, :email, :string, :required, "Admin's email"
    param :form, :password, :string, :required, "Admin's password"
    response :ok, 'Success Authentication'
    response :unauthorized, 'Invalid Credentials'
  end

  def create
    admin = Administrator.find_by_email(params[:email])
    puts admin
    puts params[:email]
    puts params[:password]
    if admin && admin.authenticate(params[:password])
      token = JwtService.encode(admin_id: admin.id, exp: 12.hours.from_now.to_i)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid Credentials' }, status: :unauthorized
    end
  end
end
