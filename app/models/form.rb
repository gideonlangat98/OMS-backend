class Form < ApplicationRecord
    belongs_to :staff, optional: true
end
