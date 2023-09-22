class Timesheet < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :staff, optional: true
end
