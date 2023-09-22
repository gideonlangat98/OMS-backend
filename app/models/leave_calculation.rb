class LeaveCalculation < ApplicationRecord
    belongs_to :leave_type, optional: true
    belongs_to :staff, optional: true
end
