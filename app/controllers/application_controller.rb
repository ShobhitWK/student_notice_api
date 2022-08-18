class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    render json: { 'message' => 'User is not authorised for this action!' }, status: 401
    p exception
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    not_found_reponse('record not found!')
    p exception
  end

  # For Optimising Code...

  def handle_error(message)
    render json: { 'message' => message }, status: :unprocessable_entity
  end

  def success_response(message)
    render json: { 'message' => message }, status: 200
  end

  def faliure_response(message)
    render json: { 'message' => message }, status: 422
  end

  def not_found_reponse(message)
    render json: { 'message' => message }, status: 404
  end

  # DEVISE PARAMS PERMITS

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:password,:role_id])
  end

  # ROLES CHECK

  def user_admin
    current_user.role.name == "admin"
  end

  def user_student
    current_user.role.name == "student"
  end

  def user_teacher
    current_user.role.name == "teacher"
  end

  private

  def show_all_notices
    notices = []
    @notices.each do |notice|
      notices << {
        id: notice.id,
        title: notice.title,
        description: notice.description,
        user: notice.user.name,
        user_role: notice.user.role.name,
        created_at: notice.created_at,
        updated_at: notice.updated_at
      }
    end
    return notices
  end

  def gen_users
    users = []
    @users.each do |user|
      users << {
        id: user.id,
        user: user.name,
        user_role: user.role.name,
        created_at: user.created_at,
        updated_at: user.updated_at
      }
    end
    return users
  end

  def gen_notices(usr)
    usr.notices do |notice|
      {
        id: notice.id,
        title: notice.title,
        description: notice.description,
        created_at: notice.created_at,
        updated_at: notice.updated_at
      }
    end
  end

end
