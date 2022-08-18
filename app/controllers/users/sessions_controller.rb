class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if current_user
      success_response("Logged in Sucessfully")
    else
      faliure_response("Login failed!")
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user
    log_out_failure
  end

  def log_out_success
    success_response("Logged out Sucessfully")
  end

  def log_out_failure
    faliure_response("Logout Failed!")
  end
end
