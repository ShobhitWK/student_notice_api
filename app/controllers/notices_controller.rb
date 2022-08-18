class NoticesController < ApplicationController
  before_action :set_notice, only: %i[ show update destroy ]

  # GET /notices
  # GET /notices.json
  def index
    @notices = Notice.all
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
  end

  # POST /notices
  # POST /notices.json
  def create
    @notice = Notice.new(notice_params)

    if @notice.save
      render :show, status: :created, location: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notices/1
  # PATCH/PUT /notices/1.json
  def update
    if @notice.update(notice_params)
      render :show, status: :ok, location: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
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
end
