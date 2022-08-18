class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: User.all
  end
end
