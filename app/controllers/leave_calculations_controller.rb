class LeaveCalculationsController < ApplicationController
  before_action :authenticate_staff, only: [:show]
  before_action :deny_access, only: [:destroy, :create, :show, :update]

  # GET /leave_calculations
  def index
    if current_admin
      leave_calculations = LeaveCalculation.all
    else
      leave_calculations = @current_staff.leave_calculations
    end

    render json: leave_calculations, status: :ok
  end

  # GET /leave_calculations/1
  def show
    leave_calculation = LeaveCalculation.find_by(id: params[:id])
    if leave_calculation
      if current_admin || leave_calculation.staff_id == @current_staff.id
        render json: leave_calculation
      else
        render_unauthorized
      end
    else
      render json: { error: "Leave Calculation not found" }, status: :not_found
    end
  end

# POST /leave_calculations
# POST /leave_calculations
def create
  staff = Staff.find_by(staff_name: leave_calculation_params[:staff_details])
  if staff
    leave_calculation = staff.leave_calculations.build(leave_calculation_params)
    update_leave_days(leave_calculation) # Calculate and update leave days
    if leave_calculation.save
      render json: leave_calculation, status: :created
    else
      render json: { error: leave_calculation.errors.full_messages }, status: :unprocessable_entity
    end
  else
    render json: { error: "Staff not found with the provided name" }, status: :not_found
  end
end

  # PATCH/PUT /leave_calculations/1
 # PATCH/PUT /leave_calculations/:id
def update
  staff = Staff.find_by(id: params[:id])
  if staff
    leave_calculation = LeaveCalculation.find_by(staff_details: staff.staff_name)
    if leave_calculation
      if leave_calculation.update(leave_calculation_params)
        update_leave_days(leave_calculation) # Recalculate and update leave days
        render json: leave_calculation, status: :ok
      else
        render json: { error: leave_calculation.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Leave Calculation not found for the specified staff" }, status: :not_found
    end
  else
    render json: { error: "Staff not found" }, status: :not_found
  end
end

  # DELETE /leave_calculations/:id
def destroy
  staff = Staff.find_by(id: params[:id])
  if staff
    leave_calculation = LeaveCalculation.find_by(staff_details: staff.staff_name)
    if leave_calculation
      leave_calculation.destroy
      head :no_content
    else
      render json: { error: "Leave Calculation not found for the specified staff" }, status: :not_found
    end
  else
    render json: { error: "Staff not found" }, status: :not_found
  end
end

  private

  # Only allow a list of trusted parameters through.
  def leave_calculation_params
    params.permit(:staff_details, :type_of_leave, :total_days, :used_days, :available_days, :leave_type_id, :staff_id)
  end

  # Update the leave days (used_days, available_days) based on total_days
  def update_leave_days(leave_calculation)
    leave_calculation.used_days = leave_calculation.total_days - leave_calculation.available_days
    leave_calculation.available_days = [leave_calculation.total_days - leave_calculation.used_days, 0].max
  end

  def deny_access
    render_unauthorized unless authenticate_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end