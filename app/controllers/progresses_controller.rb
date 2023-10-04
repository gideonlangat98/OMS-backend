class ProgressesController < ApplicationController
  before_action :authenticate_staff, only: [:show, :create, :update]
  before_action :deny_access, only: [:index, :show]

  # GET /progresses
 # In your ProgressesController
def index
  if current_admin
    @progresses = Progress.all
  else
    @progresses = Progress.where(staff_id: current_staff.id)
  end

  render json: @progresses, status: :ok
end


  # GET /progresses/1
  def show
    @progress = set_progress
    if @progress.staff_id == current_staff.id || current_admin
      render json: @progress
    else
      render json: { error: 'Unauthorized to view this progress' }, status: :unauthorized
    end
  end

  def received_progresses
    if current_admin
      @received_progresses = Progress.where(progress_sender: 'staff')
      render json: @received_progresses
    else
      render json: { error: 'Unauthorized to view received progresses' }, status: :unauthorized
    end
  end

  # POST /progresses
  def create
    @progress = Progress.new(progress_params)

    if current_staff
      @progress.progress_sender = 'staff'
    end

    @progress.staff_id = current_staff.id

    if @progress.save
      render json: @progress, status: :created
    else
      render json: { error: 'Failed to create the progress' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /progresses/1
  def update
    @progress = set_progress
    if current_staff && @progress.staff_id == current_staff.id
      if @progress.update(progress_params)
        render json: @progress, status: :ok
      else
        render json: { error: 'Failed to update the progress' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized to update this progress' }, status: :unauthorized
    end
  end

  def update_seen
    @progress = set_progress

    if current_admin
      # Update the "seen" status of the progress (you may have a field like 'seen' in your Progress model)
      @progress.update(seen: true)

      render json: @progress, status: :ok
    else
      render json: { error: 'Unauthorized to update the "seen" status of this progress' }, status: :unauthorized
    end
  end


  # DELETE /progresses/1
  def destroy
    progress = Progress.find_by(id: params[:id])
    if current_admin
      progress.destroy
      head :no_content
    else
      render json: { error: "Progress not found" }, status: :not_found
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_progress
    @progress = Progress.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def progress_params
    params.permit(:id, :progress_by, :project_managed, :assignment_name, :granted_time, :task_managed, :assigned_date, :start_date, :exceeded_by, :delivery_time)
  end

  def deny_access
    render unauthorized unless authenticate_staff
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end


end
