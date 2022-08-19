class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?

  # respond_to :json

  def create
    if current_user
    # if the role of the current login user is admin then only create a user
      if current_user.role.name == 'admin'
        if check_user_params
          build_resource(sign_up_params)
          resource.save
          yield resource if block_given?
          if resource.persisted?
            if resource.active_for_authentication?
              set_flash_message! :notice, :signed_up
              sign_up(resource_name, resource)
              respond_with resource, location: after_sign_up_path_for(resource)
            else
              set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
              expire_data_after_sign_in!
              respond_with resource, location: after_inactive_sign_up_path_for(resource)
            end
          else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
          end
        else
          faliure_response({message:"Wrong Parameters provided!"})
        end
      else
        # else send registration failed or not authorize message
        register_failed
      end
    else
      faliure_response({Error: 'Only admins can create new users!'})
    end
  end

  private

  # Check whether user got registered or not
  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?
    register_failed
  end

  # This method will called if the user registration is sucessfull
  def register_success
    render json: { "User Created" => resource_generate(resource) }
  end

  # Failed responses
  def faliure_response(message)
    render json: message, status: :unprocessable_entity
  end

  # This method will called if the user registration is failed
  def register_failed
    handle_error(resource.errors.messages)
  end

  # Check for user params
  def check_user_params
    params[:user].present?
  end

  # Method to generate information of new registered user
  def resource_generate(resource)
    {
      id: resource.id,
      name: resource.name,
      role_id: resource.role_id,
      role: resource.role.name,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
