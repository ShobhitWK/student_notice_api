class Notice::NoticesController < ApplicationController

  load_and_authorize_resource
  before_action :set_notice, only: %i[ show update destroy ]

  def index
    @notices = Notice.all
    render json: show_all_notices
  end

  def show
    render json: show_notice
  end

  def create
    @notice = Notice.new(notice_params)
    @notice.user = current_user
    if @notice.save
      render :show, status: :created, location: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  def update
    if @notice.update(notice_params)
      render :show, status: :ok, location: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @notice.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notice_params
      params.require(:notice).permit(:title, :description, :user_id)
    end

    def show_notice
      {
        id: @notice.id,
        title: @notice.title,
        description: @notice.description,
        user: @notice.user.name,
        user_role: @notice.user.role.name,
        created_at: @notice.created_at,
        updated_at: @notice.updated_at
      }
    end
end
