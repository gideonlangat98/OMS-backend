class RequestsController < ApplicationController
    before_action :deny_access, only: [:create, :update, :show]
  
      # GET /  Managers
      def index
       @requests = Request.all
        render json: @requests
      end
    
      # GET /  Managers/1
      def show
       @requests = set_request
        render json: @requests
      end
    
      # POST /  Managers
      def create
       @requests = Request.create(request_params)
        render json: @requests, status: :created
      end
    
      # PATCH/PUT /  Managers/1
      def update
       @requests = set_request
       @requests.update(request_params)
        render json: @requests, status: :created
      end
    
      # DELETE /  Managers/1
      def destroy
       @requests = set_request
       @requests.destroy
        head :no_content
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_request
         @requests = Request.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def request_params
          params.permit(:id, :request_by, :task_request, :request_detail, :request_date, :request_to, :staff_id)
        end
  
        def deny_access
          render_unauthorized unless authenticate_staff
        end
      
        def render_unauthorized
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
  end
  