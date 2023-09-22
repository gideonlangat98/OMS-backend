class LeaveTypesController < ApplicationController
  before_action :authenticate_staff, only: [:show]
  before_action :deny_access, only: [:create, :show, :destroy, :update]

  # GET /leave_types
  def index
    leave_types = LeaveType.all
    render json: leave_types
  end

  # GET /leave_types/1
  def show
    leave_type = LeaveType.find_by(id: params[:id])
    if leave_type
      render json: leave_type
    else
      render json: { error: "Leave Type not found" }, status: :not_found
    end
  end

  # POST /leave_types
  def create
    leave_type = LeaveType.create(leave_type_params)
    render json: leave_type, status: :created
  end

  # PATCH/PUT /leave_types/1
  def update
    leave_type = LeaveType.find_by(id: params[:id])
    if leave_type
      leave_type.update(leave_type_params)
      render json: leave_type, status: :ok
    else
      render json: { error: "Leave Type not found" }, status: :not_found
    end
  end

  # DELETE /leave_types/1
  def destroy
    leave_type = LeaveType.find_by(id: params[:id])
    if leave_type
      leave_type.destroy
      head :no_content
    else
      render json: { error: "Leave Type not found" }, status: :not_found
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def leave_type_params
    params.permit(:id, :leave_reason, :days_allowed, :staff_id)
  end

  def deny_access
    render_unauthorized unless authenticate_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

end
