class Users::RolesController < ApplicationController

  load_and_authorize_resource
  before_action :set_role, only: %i[ show update destroy ]

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
    success_response @roles
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    if @role.save
      render :show, status: :created, location: @role
    else
      handle_error @role.errors
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    if @role.update(role_params)
      render :show, status: :ok, location: @role
    else
      handle_error @role.errors
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
  end

  private
    # # To check if the user has perms to view this page or not
    # def check_if_logged_in
    #   unless current_user
    #     faliure_response("Login first to perform this action!")
    #   end
    # end

    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.require(:role).permit(:name)
    end
end
