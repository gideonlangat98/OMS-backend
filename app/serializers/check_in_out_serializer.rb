class CheckInOutSerializer < ActiveModel::Serializer
  attributes :id, :staff_id, :name, :duration, :check_in, :online_state, :last_logged, :check_out, :formatted_created_at

  def formatted_created_at
    object.created_at.localtime.strftime('%Y-%m-%d %H:%M:%S')
  end
end
