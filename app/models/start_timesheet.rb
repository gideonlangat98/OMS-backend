class StartTimesheet < Timesheet
    belongs_to :staff, optional: true

    validates :date, :start_time, :task_detail, :time_limit, presence: true

  end