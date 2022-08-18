class Users::MembersController < ApplicationController

  before_action :authenticate_user! # Without login, user cannot see his profile

  # This will show current user profile -> localhost:port/profile
  def show
    show_info current_user_data
  end

  private

  # Creating user information in json
  def current_user_data

    data = {
      id: current_user.id,
      name: current_user.name,
      email: current_user.email,
      role_id: current_user.role_id,
      role: current_user.role.name
    }

    if user_admin or user_teacher

      data = {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email,
        role_id: current_user.role_id,
        role: current_user.role.name,
        notice_count: current_user.notices.length,
        notices: gen_notices(current_user)
      }

    end

    return data
  end


end
