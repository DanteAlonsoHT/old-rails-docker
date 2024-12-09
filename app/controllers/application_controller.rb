class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_admin!
    header = request.headers['Authorization']
    if header.present?
      token = header.split(' ').last
      decoded = JwtService.decode(token)
      if decoded && decoded['admin_id']
        @current_admin = Administrator.find(decoded['admin_id']) rescue nil
      end
    end
    render json: { error: 'Not authorized' }, status: :unauthorized unless @current_admin
  end
end
