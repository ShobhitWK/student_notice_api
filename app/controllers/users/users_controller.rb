class Users::UsersController < ApplicationController
  # load_and_authorize_resource
  before_action :get_user_data, except: %i[index]

  def index
    @users = User.all if user_admin
    @users = User.where(role: 3) if user_teacher
    @users = User.where.not(role: 3) if user_student
    render json: { users: gen_users }
  end

  def show
    return render json: { user: user_info } if able_to_show
    error_message 'This User Not Authorised !'
  end

  def update
    if @user.update(user_params)
      render json: { message: 'user updated succesfully', user: user_info }
    else
      error_message @user.errors.messages
    end
  end

  def destroy
    if @user.destroy
      render json: { message:'user deleted succesfully' }, status: :created
    else
      render json: { message: 'Error Occured! User is not deleted' }, status: :not_modified
    end
  end

  def update_role
    if @user.update(role_params)
      render json: { message: 'Role updated successfully' }
    else
      render json: { message: 'nothing happened' }
    end
  end

  private

  def role_params
    params.require(:user).permit(:role_id)
  end

  def able_to_show
    current_role = current_user.role.name
    user_role = @user.role.name
    is_able = false
    is_able = true if current_user == @user
    is_able = true if current_role == 'admin' and user_role != current_role
    is_able = true if current_role == 'teacher' and user_role == 'student'
    is_able = true if current_role == 'student' and (user_role == 'teacher' or user_role == 'admin')
    return is_able
  end

  def user_params
    params.require(:user).permit(:f_name, :l_name, :email, :password, :role_id)
  end

  def get_user_data
    @user = User.includes(:role).find(params[:id])
  end

  def user_info
    user_role = @user.role.name
    return for_student if user_role == 'student'
    return for_not_student if user_role != 'student'
  end

  def for_not_student
    {
      id: @user.id,
      name: @user.name,
      email: @user.email,
      role: @user.role.name,
      notices: gen_notices(@user)
    }
  end

  def for_student
    {
      id: @user.id,
      name: @user.name,
      email: @user.email,
      role: @user.role.name
    }
  end
end
