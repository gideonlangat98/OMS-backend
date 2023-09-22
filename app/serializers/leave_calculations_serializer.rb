class LeaveCalculationsSerializer < ActiveModel::Serializer
  attributes :id, :staff_details, :type_of_leave, :total_days, :used_days, :available_days, :leave_type_id, :staff_id

  belongs_to :leave_type
  belongs_to :staff
end
