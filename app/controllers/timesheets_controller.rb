class TimesheetsController < ApplicationController
  before_action :authenticate_staff, only: [:index, :show, :create, :update]
  before_action :deny_access, only: [:destroy, :show, :update]

  # GET /timesheets
def index
  if current_admin
    timesheets = Timesheet.all
  else
    timesheets = @current_staff.timesheets
  end
  
  render json: timesheets, status: :ok
end


  # GET /timesheets/1
def show
  timesheet = Timesheet.find_by(id: params[:id])
  if timesheet
    if current_admin || timesheet.staff_id == @current_staff.id
      render json: timesheet
    else
      render_unauthorized
    end
  else
    render json: { error: "Timesheet not found" }, status: :not_found
  end
end

  # POST /timesheets
  def create
    timesheet = @current_staff.timesheets.create(timesheet_params)
    timesheet.staff_id = @current_staff.id
    if timesheet.save
      render json: timesheet, status: :created
    else
      render json: { error: timesheet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /timesheets/1
  def update
    timesheet = current_staff.timesheets.find_by(id: params[:id])
    if timesheet
      if timesheet.update(timesheet_params)
        render json: timesheet
      else
        render json: { error: timesheet.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Timesheet not found" }, status: :not_found
    end
  end

  # DELETE /timesheets/1
  def destroy
    timesheet = Timesheet.find_by(id: params[:id])
    if timesheet
      timesheet.destroy
      head :no_content
    else
      render json: { error: "Timesheet not found" }, status: :not_found
    end
  end

  private

  def timesheet_params
    params.permit(:date, :start_time, :end_time, :task_detail, :time_limit, :progress_details, :task_id, :staff_id)
  end

  def deny_access
    render_unauthorized unless current_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end