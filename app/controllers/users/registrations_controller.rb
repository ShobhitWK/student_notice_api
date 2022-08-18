class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { "User Created" => resource_generate(resource) }
    # success_response("Signed Up Sucessfully.")
  end

  def register_failed
    handle_error(resource.errors)
  end

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
