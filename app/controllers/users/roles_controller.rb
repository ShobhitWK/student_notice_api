class Users::RolesController < ApplicationController

  load_and_authorize_resource # This is for configuring cancancan ability

  before_action :set_role, only: %i[ show update destroy ]

  def index
    @roles = Role.all
    show_info @roles
  end

  def show
    show_info @role
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      render json: {message: "Role created sucessfully.", role_info: @role }, status: :created, location: @role
    else
      handle_error @role.errors
    end
  end

  def update
    if @role.update(role_params)
      render json: {message: "Role edited sucessfully.", role_info: @role }, status: :ok, location: @role
    else
      handle_error @role.errors
    end
  end

  def destroy
    @role.destroy
    success_response("#{@role.name} has been deleted sucessfully.")
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.require(:role).permit(:name)
    end
end
