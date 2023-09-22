class StartTimesheetsController < ApplicationController
    before_action :authenticate_staff  # You might want to authenticate staff for these actions
  
    # POST /start_timesheets
    def create
        start_timesheet = StartTimesheet.new(start_timesheet_params)
      
        if start_timesheet.save
          render json: start_timesheet, status: :created
        else
          # Log errors to the console for debugging
          puts start_timesheet.errors.full_messages.join(', ')
          render json: { errors: start_timesheet.errors.full_messages }, status: :unprocessable_entity
        end
    end  
  

    # def download_completed_file
    #   task = Task.find_by(id: params[:id])
    
    #   if task
    #     if task.completed_files.present?
    #       file = task.completed_files.first
    
    #       if file.present?
    #         send_file file.download, disposition: 'attachment', filename: file.filename.to_s, type: file.content_type
    #       else
    #         head :not_found
    #       end
    #     else
    #       render json: { error: 'No completed files attached' }, status: :unprocessable_entity
    #     end
    #   else
    #     render json: { error: 'Task not found' }, status: :not_found
    #   end
    # end  
  
    # GET /start_timesheets/:id
    def show
      start_timesheet = StartTimesheet.find(params[:id])
      render json: start_timesheet
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Start timesheet not found' }, status: :not_found
    end
  
    # PATCH/PUT /start_timesheets/:id
    def update
      start_timesheet = StartTimesheet.find(params[:id])
  
      if start_timesheet.update(start_timesheet_params)
        render json: start_timesheet
      else
        render json: { errors: start_timesheet.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Start timesheet not found' }, status: :not_found
    end
  
    # DELETE /start_timesheets/:id
    def destroy
      start_timesheet = StartTimesheet.find(params[:id])
      start_timesheet.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Start timesheet not found' }, status: :not_found
    end
  
    private
  
    def start_timesheet_params
      params.require(:timesheet).permit(:date, :start_time, :task_detail, :time_limit, :staff_id)
    end
  end  