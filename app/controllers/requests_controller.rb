class RequestsController < ApplicationController
  before_action :authenticate_staff, only: [:show, :create, :update, :destroy]
  before_action :deny_access, except: [:destroy, :index, :show]

  # GET /requests
  def index
    if current_admin
      @requests = Request.all
    else
      @requests = Request.where(staff_id: current_staff.id)
    end
    render json: @requests
  end

  # GET /requests/1
  def show
    @request = set_request
    if @request.staff_id == current_staff.id || current_admin
      render json: @request
    else
      render json: { error: 'Unauthorized to view this request' }, status: :unauthorized
    end
  end

  # POST /requests
  def create
    @request = Request.new(request_params)
    @request.staff = current_staff

    if @request.save
      render json: @request, status: :created
    else
      render json: { error: 'Failed to create the request' }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /requests/1
  def update
    @request = set_request
    if current_staff && @request.staff_id == current_staff.id
      if @request.update(request_params)
        render json: @request, status: :ok
      else
        render json: { error: 'Failed to update the request' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized to update this request' }, status: :unauthorized
    end
  end

  # DELETE /requests/1
  def destroy
    request = Request.find_by(id: params[:id])
    if request
      request.destroy
      head :no_content
    else
      render json: { error: "Request not found" }, status: :not_found
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.permit(:request_by, :task_request, :request_detail, :request_date, :request_to)
  end

  def deny_access
    render_unauthorized unless authenticate_staff
  end

   def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

end
