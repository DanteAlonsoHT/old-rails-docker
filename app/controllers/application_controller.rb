class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_admin
  after_filter :reset_current

  def authenticate_admin!
    header = request.headers['Authorization']
    if header.present?
      token = header.split(' ').last
      decoded = JwtService.decode(token) rescue nil
      if decoded && decoded['admin_id']
        @current_admin = Administrator.find(decoded['admin_id']) rescue nil
      end
    end
    unless @current_admin
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end

  private

  def current_admin
    @current_admin
  end

  def set_current_admin
    Current.admin_id = current_admin.try(:id) || Administrator.first.id
  end

  def reset_current
    Current.reset
  end
end
