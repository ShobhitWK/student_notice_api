class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    render json: { 'message' => 'User is not authorised!' }, status: 401
    p exception
  end

  rescue_from ActionController::RoutingError, with: :render_404

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { 'message' => 'record not found!' }, status: 404
    p exception
  end

  def success_response(message)
    render json: { 'message' => message }, status: 200
  end

  def faliure_response(message)
    render json: { 'message' => message }, status: 422
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:password,:role_id])
  end

  private

  def render_404
    respond_to do |format|
      format.html { render "#{Rails.root}/public/404.html", status: 404 }
      format.json { render json: { status: 404, message: 'Page Not Found' } }
    end
  end

end
