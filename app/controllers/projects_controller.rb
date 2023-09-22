class ProjectsController < ApplicationController
  before_action :authenticate_staff, only: [:show]
  before_action :deny_access, only: [:destroy, :create, :show, :update]
  
  # GET /projects
  def index
    projects = Project.all
    render json: projects
  end

  # GET /projects/1
  def show
    project = Project.find_by(id: params[:id])
    if project
      render json: project
    else
      render json: { error: "Project not found" }, status: :not_found
    end
  end

  # POST /projects
  def create
    project = Project.create(project_params)
    render json: project, status: :created
  end

  # PATCH/PUT /projects/1
  def update
    project = Project.find_by(id: params[:id])
    if project
      project.update(project_params)
      render json: project, status: :created
    else
      render json: { error: "Project not found" }, status: :not_found
    end
  end

  # DELETE /projects/1
  def destroy
    project = Project.find_by(id: params[:id])
    if project
      project.destroy
      head :no_content
    else
      render json: { error: "Project not found" }, status: :not_found
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def project_params
    params.permit(:project_name, :description, :client_details, :project_managers, :task_managers, :client_id)
  end

  def deny_access
    render_unauthorized unless authenticate_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

end
