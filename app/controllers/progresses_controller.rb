class ProgressesController < ApplicationController
    before_action :deny_access, only: [:create, :update, :show]
  
      # GET /  Managers
      def index
       @progress = Progress.all
        render json: @progress
      end
    
      # GET /  Managers/1
      def show
       @progress = set_progress
        render json: @progress
      end
    
      # POST /  Managers
      def create
       @progress =Progress.create(progress_params)
        render json: @progress, status: :created
      end
    
      # PATCH/PUT /  Managers/1
      def update
       @progress = set_progress
       @progress.update(progress_params)
        render json: @progress, status: :created
      end
    
      # DELETE /  Managers/1
      def destroy
       @progress = set_progress
       @progress.destroy
        head :no_content
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_progress
         @progress = Progress.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def progress_params
          params.permit(:id, :progress_by, :project_managed, :task_managed, :assigned_date, :start_date, :exceeded_by, :delivery_time)
        end
  
        def deny_access
          render_unauthorized unless authenticate_staff
        end
      
        def render_unauthorized
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
  end
  