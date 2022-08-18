class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user_data
  end

  private

  def current_user_data

    data = {
      id: current_user.id,
      name: current_user.name,
      email: current_user.email,
      role_id: current_user.role_id,
      role: current_user.role.name
    }

    if current_user.role_id == 2

      data = {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email,
        role_id: current_user.role_id,
        role: current_user.role.name,
        notice_count: current_user.notices.length
      }
      
    end

    return data
  end

end
