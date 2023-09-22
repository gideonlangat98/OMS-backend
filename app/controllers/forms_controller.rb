class FormsController < ApplicationController
  before_action :authenticate_staff, only: [:index, :show, :create]
  before_action :deny_access, only: [:destroy, :show, :update]

  # GET /leave_forms
  def index
    if current_admin
      forms = Form.all
    else
      # Get the staff's name from the currently logged-in staff and set it as the default value for :your_name.
      your_name = @current_staff.staff_name
      forms = @current_staff.forms.map { |form| form.attributes.merge(your_name: your_name) }
    end
    
    render json: forms, status: :ok
  end
  
    # GET /forms/1
    def show
      form = Form.find_by(id: params[:id])
      if form
        if current_admin || form.staff_id == @current_staff.id
          render json: form
        else
          render_unauthorized
        end
      else
        render json: { error: "Timesheet not found" }, status: :not_found
      end
    end
  
    # POST /forms
    def create
      form = @current_staff.forms.build(form_params)
      form.your_name = @current_staff.staff_name # Set the your_name attribute to the staff's name
      form.staff_id = @current_staff.id
  
      if form.save
        render json: form, status: :created
      else
        render json: { error: form.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
    # PATCH/PUT /tasks/1
    def update
      form = Form.find_by(id: params[:id])
      if form
        if form.update(form_params)
          render json: form
        else
          render json: { error: task.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: "Task not found" }, status: :not_found
      end
    end
  
    # DELETE /tasks/1
    def destroy
      form = Form.find_by(id: params[:id])
      if form
        form.destroy
        head :no_content
      else
        render json: { error: "form not found" }, status: :not_found
      end
    end

  private

  # Only allow a list of trusted parameters through.
  def form_params
    params.permit(:your_name, :date_from, :date_to, :days_applied, :leaving_type, :reason_for_leave, :status, :staff_id)
  end

  def deny_access
    render_unauthorized unless current_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
