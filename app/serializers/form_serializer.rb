class FormSerializer < ActiveModel::Serializer
  attributes :id, :your_name, :date_from, :date_to, :leaving_type, :days_applied, :reason_for_leave, :status, :staff_id

  belongs_to :staff
end
