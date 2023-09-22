class CheckInOut < ApplicationRecord
  belongs_to :staff, optional: true

  attribute :name, :string
  attribute :duration, :string
  attribute :online_state, :string
  attribute :last_logged, :string

  # Calculate the duration based on timecheckedin and timecheckedout
  def calculate_duration
    if check_in.present? && check_out.present?
      # Calculate the duration in hours (assuming timecheckedin and timecheckedout are in DateTime format)
      hours_duration = ((check_out - check_in) / 1.hour).round(2)
      self.duration = "#{hours_duration} hours"
    else
      self.duration = nil
    end
  end

  # You might want to call this method after saving a record to update the duration
  after_save :calculate_duration

  # Callback to set online_state and last_logged when checking in
  before_create :set_online_state_and_last_logged_on_checkin

  # Callback to update last_logged when checking out and set online_state to 'offline'
  before_update :set_online_state_and_last_logged_on_checkout

  private

  def set_online_state_and_last_logged_on_checkin
    self.online_state = 'online' if check_in.present?
    self.last_logged = 'Active' if check_in.present? # Set to 'Active' on check-in
  end

  def set_online_state_and_last_logged_on_checkout
    if check_out.present?
      self.online_state = 'offline'
      self.last_logged = check_out # Set to checkout time on check-out
    end
  end
end
