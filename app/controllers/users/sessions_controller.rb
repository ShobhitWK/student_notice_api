class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if current_user
      success_response("User Logged in Sucessfully")
    else
      faliure_response("User is not logged in.")
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user
    log_out_failure
  end

  def log_out_success
    success_response("User Logged out Sucessfully")
  end

  def log_out_failure
    faliure_response("User Logout Failed!")
  end
end
