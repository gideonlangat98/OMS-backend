class StartTimesheetSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :task_detail, :time_limit, :staff_id

  belongs_to :staff, optional: true
end
