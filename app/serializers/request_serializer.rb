class RequestSerializer < ActiveModel::Serializer
  attributes :id, :request_by, :task_request, :request_detail, :request_date, :request_to, :staff_id

  belongs_to :staff, otptional: true
end
