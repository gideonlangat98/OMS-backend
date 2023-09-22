class LeaveType < ApplicationRecord
    belongs_to :staff, optional: true

    has_many :leave_calculations
end
