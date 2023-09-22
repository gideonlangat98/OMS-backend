class ProfilesController < ApplicationController
  before_action :authenticate_staff
  before_action :deny_access, only: [:show, :update, :destroy]

  def index
    profiles = current_staff.profile
    render json: profiles, status: :ok
  end

  def create
    @profile = @current_staff.build_profile(profile_params)
    if @profile.save
      render json: @profile, status: :created
    else
      render json: { error: @profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @profile = Profile.find_by(id: params[:id])
    if @profile
      render json: @profile
    else
      render json: { error: "Profile not found" }, status: :not_found
    end
  end

  def update
    profile = Profile.find_by(id: params[:id])
    if @current_staff.profile.update(profile_params)
      render json: @current_staff.profile, status: :created
    else
      render json: { error: "Profile not found" }, status: :not_found
    end
  end

  def destroy
    @profile = Profile.find_by(id: params[:id])
    if @profile
      @profile.destroy
      head :no_content
    else
      render json: { error: "Profile not found" }, status: :not_found
    end
  end

  private

  def profile_params
    params.permit(:avatar, :bio, :about, :location, :bio_name, :my_email, :tech)
  end

  def deny_access
    render_unauthorized unless @current_staff
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
