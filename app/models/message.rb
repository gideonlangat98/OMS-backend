class Message < ApplicationRecord
  belongs_to :admin, optional: true
  belongs_to :staff, optional: true

  enum sender_type: { admin: 'admin', staff: 'staff' }

  validates :sender_type, presence: true
end
