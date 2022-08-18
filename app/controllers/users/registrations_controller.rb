class Users::RegistrationsController < Devise::RegistrationsController

  before_action :authenticate_user! 
  respond_to :json

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

  # This method will called if the user registration is failed
  def register_failed
    handle_error(resource.errors)
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
