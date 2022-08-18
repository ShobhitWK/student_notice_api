class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    success_response("If you see this, you're in!")
  end
end
