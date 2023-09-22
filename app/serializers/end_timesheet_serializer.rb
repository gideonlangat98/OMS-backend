class EndTimesheetSerializer < ActiveModel::Serializer
  attributes :id, :date, :end_time, :task_detail, :progress_details, :staff_id
  belongs_to :staff, optional: true
end
