class EndTimesheet < Timesheet
     belongs_to :staff, optional: true

     validates :date, :end_time, :task_detail, :progress_details, presence: true
end