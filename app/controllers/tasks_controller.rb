class TasksController < ApplicationController
  before_action :authenticate_staff, only: [:index, :show, :update, :create, :upload_completed_files]
  before_action :deny_access, only: [:create, :destroy]
  # before_action :authenticate_staff_or_admin, only: [:download_completed_file]

    # Add this action to the TasksController
    def received_tasks
      if current_staff
        # If the current user is a staff member, retrieve tasks sent by admin and staff.
        @received_tasks = Task.where(assigned_to: current_staff.staff_name, send_type: ['admin', 'staff'])
      else
        # Handle the case when the user is not authenticated as staff.
        render json: { error: 'Authentication required for staff access' }, status: :unauthorized
      end
    
      render json: @received_tasks
    end

# Add this action to the TasksController
def admin_received_tasks
  if current_admin
    # If the current user is an admin, retrieve tasks sent by staff members.
    @admin_received_tasks = Task.where(send_type: 'staff', task_manager: current_admin.first_name)
  else
    # Handle the case when the user is not authenticated as an admin.
    render json: { error: 'Authentication required for admin access' }, status: :unauthorized
  end

  render json: @admin_received_tasks
end

# Add this action to the TasksController
def admin_sent_tasks_to_staff
  if current_admin
    staff_id = params[:staff_id] # Retrieve the staff_id parameter from the URL
    if staff_id.present?
      # If a staff_id parameter is provided, filter tasks sent to that staff member.
      @admin_sent_tasks = Task.where(send_type: 'admin', assigned_to: Staff.find(staff_id).staff_name)
    else
      # If no staff_id parameter is provided, return an empty array.
      @admin_sent_tasks = []
    end
  else
    # Handle the case when the user is not authenticated as an admin.
    render json: { error: 'Authentication required for admin access' }, status: :unauthorized
  end

  render json: @admin_sent_tasks
end

# Add this action to the TasksController
def admin_all_tasks
  if current_admin
    # If the current user is an admin, retrieve all tasks.
    @admin_all_tasks = Task.all
  else
    # Handle the case when the user is not authenticated as an admin.
    render json: { error: 'Authentication required for admin access' }, status: :unauthorized
  end

  render json: @admin_all_tasks
end

def admin_received_completed_files
  if current_admin
    # If the current user is an admin, retrieve completed files sent by staff.
    @admin_received_completed_files = Task.where(send_type: 'staff')
  else
    # Handle the case when the user is not authenticated as an admin.
    render json: { error: 'Authentication required for admin access' }, status: :unauthorized
  end

  render json: @admin_received_completed_files
end


    # GET /tasks/1
    def show
      task = Task.find_by(id: params[:id])
      if task
        if current_staff || task.staff_name == @current_staff.name
          render json: task
        else
          render_unauthorized
        end
      else
        render json: { error: "Task not found" }, status: :not_found
      end
    end
  
    # POST /tasks
    def create
      task = Task.new(task_params)
      
      # Set the send_type attribute to 'admin' for tasks created by the current admin
      if current_admin
        task.send_type = 'admin'
      end
    
      task.staff_id = @current_staff.id if @current_staff
    
      if task.save
        render json: task, status: :created
      else
        render json: { error: task.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
    def update
      task = Task.find_by(id: params[:id])
      if task
        if current_staff && task.assigned_to == current_staff.staff_name
          # Staff members can update tasks, including the isComplete attribute
          if task.update(task_params)
            render json: task
          else
            render json: { error: task.errors.full_messages }, status: :unprocessable_entity
          end
        elsif current_admin
          # Admins can update tasks, except for the isComplete attribute
          if task_params[:isComplete].present?
            render json: { error: "Admins cannot update the 'isComplete' attribute" }, status: :unprocessable_entity
          else
            if task.update(task_params.except(:isComplete))
              render json: task
            else
              render json: { error: task.errors.full_messages }, status: :unprocessable_entity
            end
          end
        else
          render_unauthorized
        end
      else
        render json: { error: "Task not found" }, status: :not_found
      end
    end    
  
    # DELETE /tasks/1
    def destroy
      task = Task.find_by(id: params[:id])
      if task
        if current_admin || task.staff_id == @current_staff.id
          task.destroy
          head :no_content
        else
          render_unauthorized
        end
      else
        render json: { error: "Task not found" }, status: :not_found
      end
    end
  
    def upload_completed_files
      task = Task.find_by(id: params[:task_id])
      
      if task
        if current_staff && task.assigned_to == current_staff.staff_name
          if params[:completed_files].present?
            # Convert the completed_files attribute to an array if it is nil or a string
            task.completed_files = [] if task.completed_files.nil? || task.completed_files.is_a?(String)
            
            # Append the new file URLs to the existing completed_files array
            new_completed_files = task.completed_files + Array(params[:completed_files])
    
            # Set the send_type of completed_files to 'staff'
            task.update(completed_files: new_completed_files, send_type: 'staff')
            
            render json: task, status: :ok
          else
            render json: { error: "No completed files attached" }, status: :unprocessable_entity
          end
        else
          render_unauthorized
        end
      else
        render json: { error: "Task not found" }, status: :not_found
      end
    end
    
    
    def completed_tasks
      if current_staff || current_admin
        tasks_with_completed_files = Task.where.not(completed_files: nil)
    
        # Prepare a new array to hold the tasks with completed file URLs
        tasks_with_urls = tasks_with_completed_files.map do |task|
          task_with_url = task.as_json
    
          if task.completed_files.is_a?(Array)
            task_with_url["completed_files"] = task.completed_files.map do |file|
              file.url
            end
          else
            task_with_url["completed_files"] = [task.completed_files.url]
          end
    
          task_with_url
        end
    
        render json: tasks_with_urls, status: :ok
      else
        render_unauthorized
      end
    end  
  
    def download_avatar
      task = Task.find(params[:id])
      file_path = task.avatar_image.path 
      send_file file_path, disposition: 'attachment'
    end
  
    def download_completed_file
      task = Task.find_by(id: params[:task_id])
  
      if task && task.completed_files.present? && (current_admin || current_staff )
        file_index = params[:file_index].to_i
  
        if file_index >= 0 && file_index < task.completed_files.length
          file_path = task.completed_files[file_index].path
          send_file file_path, disposition: 'attachment'
        else
          render json: { error: "Invalid file index" }, status: :bad_request
        end
      else
        render_unauthorized
      end
    end
  
    private
  
    def task_params
      params.permit(:id, :avatar_image, :completed_files, :assignment_date, :completion_date, :task_name, :assigned_to, :task_manager, :project_manager, :project_name, :task_deadline, :project_id, :isComplete, :staff_id)
    end
  
    def deny_staff
      render_unauthorized unless current_admin
    end
  
    def deny_access
      render_unauthorized unless current_admin || (action_name == 'upload_completed_files' && current_staff && task_belongs_to_current_staff?)
    end 
  
    def task_belongs_to_current_staff?
      task = Task.find_by(id: params[:id])
      task && task.staff_id == @current_staff.id
    end

    def staff_can_update_is_complete?(task)
      current_staff && task.assigned_to == current_staff.staff_name
    end
  
    def render_unauthorized
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
  