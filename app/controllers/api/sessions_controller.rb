class Api::SessionsController < ApplicationController
  def create
    admin = Administrator.find_by_email(params[:email])
    puts admin
    puts admin.authenticate(params[:password])
    if admin && admin.authenticate(params[:password])
      token = JwtService.encode(admin_id: admin.id, exp: 12.hours.from_now.to_i)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid Credentials' }, status: :unauthorized
    end
  end
end
