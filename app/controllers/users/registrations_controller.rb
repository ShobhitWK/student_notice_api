class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    success_response("Signed Up Sucessfully.")
  end

  def register_failed
    faliure_response("Something went wrong.")
  end
end
