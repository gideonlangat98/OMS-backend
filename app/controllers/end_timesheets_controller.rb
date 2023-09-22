class EndTimesheetsController < ApplicationController
    before_action :authenticate_staff  # You might want to authenticate staff for these actions
  
    # POST /end_timesheets
    def create
      end_timesheet = EndTimesheet.new(end_timesheet_params)
  
      if end_timesheet.save
        render json: end_timesheet, status: :created
      else
        render json: { errors: end_timesheet.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # GET /end_timesheets/:id
    def show
      end_timesheet = EndTimesheet.find(params[:id])
      render json: end_timesheet
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'End timesheet not found' }, status: :not_found
    end
  
    # PATCH/PUT /end_timesheets/:id
    def update
      end_timesheet = EndTimesheet.find(params[:id])
  
      if end_timesheet.update(end_timesheet_params)
        render json: end_timesheet
      else
        render json: { errors: end_timesheet.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'End timesheet not found' }, status: :not_found
    end
  
    # DELETE /end_timesheets/:id
    def destroy
      end_timesheet = EndTimesheet.find(params[:id])
      end_timesheet.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'End timesheet not found' }, status: :not_found
    end
  
    private
  
    def end_timesheet_params
      params.require(:timesheet).permit(:date, :end_time, :task_detail, :progress_details, :staff_id)
    end
  end
  