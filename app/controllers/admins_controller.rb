class AdminsController < ApplicationController
  before_action :deny_access, except: [:destroy, :create, :update, :show]

  def index
    admin = Admin.all
    render json: admin, status: :ok
  end

  def create
    admin = Admin.create(admin_params)
    if admin.save
      render json: admin, status: :created
    else
      render json: { error: admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: admin, status: :ok
  end

  def update
    admin = set_admin
    if admin.update(admin_params)
      render json: admin
    else
      render json: { error: admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    admin.destroy
    head :no_content
  end

  private

  def set_admin
    admin = Admin.find(params[:id])
  end

  def admin_params
    params.permit(:id, :first_name, :last_name, :email, :password, :password_confirmation, :isadmin)
  end

  def deny_access
    render_unauthorized unless authenticate_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
