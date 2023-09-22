class CheckInOutsController < ApplicationController
  before_action :authenticate_staff, only: [:check_in, :check_out, :online_state, :last_logged, :index, :show, :destroy]
  
  def index
    check_in_outs = CheckInOut.all
    render json: check_in_outs, each_serializer: CheckInOutSerializer
  end

  def show
    check_in_out = CheckInOut.find(params[:id])
    render json: check_in_out
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'CheckInOut not found' }, status: :not_found
  end

  def check_in
    if @current_staff
      current_time = Time.now
      local_time = current_time.in_time_zone('Nairobi')
      
      # Check if there is a previous check-in record for today
      last_check_in = CheckInOut.where(staff_id: @current_staff.id)
                                .where('check_in >= ?', local_time.beginning_of_day)
                                .where('check_in <= ?', local_time.end_of_day)
                                .last

      if last_check_in
        render json: { error: 'You have already checked in today' }, status: :unprocessable_entity
      else
        check_in_out = CheckInOut.create(
          check_in: local_time,
          staff_id: @current_staff.id,
          name: @current_staff.staff_name
        )

        render json: {
          check_in_out: check_in_out,
          name: @current_staff.staff_name
        }, status: :created
      end
    else
      render_unauthorized
    end
  end

  def check_out
    if @current_staff
      check_in_out = CheckInOut.where(staff_id: @current_staff.id, check_out: nil).last

      if check_in_out
        check_in_out.update(check_out: Time.now)
        # Set last_logged to the check_out timestamp
        check_in_out.update(last_logged: check_in_out.check_out)
        # Set online_state to 'offline'
        check_in_out.update(online_state: 'offline')
        
        render json: check_in_out, status: :created
      else
        render json: { error: 'No active check-in found' }, status: :not_found
      end
    else
      render_unauthorized
    end
  end

  def destroy
    check_in_out = CheckInOut.find(params[:id])
    check_in_out.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'CheckInOut not found' }, status: :not_found
  end

  private

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
