class PullTimesController < ApplicationController
  before_action :set_pull_time, only: %i[show edit update destroy]

  # GET /pull_times or /pull_times.json
  def index
    @pull_times = PullTime.all
  end

  # GET /pull_times/1 or /pull_times/1.json
  def show; end

  # GET /pull_times/1/edit
  def edit; end

  # PATCH/PUT /pull_times/1 or /pull_times/1.json
  def update
    respond_to do |format|
      if @pull_time.update(pull_time_params)
        format.html { redirect_to pull_time_url(@pull_time), notice: "Pull time was successfully updated." }
        format.json { render :show, status: :ok, location: @pull_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pull_time.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pull_time
    @pull_time = PullTime.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pull_time_params
    params.require(:pull_time).permit(:weekday, :start_time, :end_time)
  end
end