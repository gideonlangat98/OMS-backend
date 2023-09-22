class LeaveTypeSerializer < ActiveModel::Serializer
  attributes :id, :leave_reason, :days_allowed, :staff_id

  belongs_to :staff
  has_many :leave_calculations
end
