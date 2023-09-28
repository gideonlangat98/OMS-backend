class TimesheetSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time, :task_detail, :task_stuffs, :addressed_issue, :issues_discussed, :issues_sorted, :sorted_by, :time_limit, :progress_details, :task_id, :staff_id

  belongs_to :task
  belongs_to :staff
end
