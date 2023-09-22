class Request < ApplicationRecord
    belongs_to :staff, optional: true
end
