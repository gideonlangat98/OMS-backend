class EventSerializer < ActiveModel::Serializer
  attributes :id, :date, :time,:agenda, :host, :trainer, :documents, :email, :meeting_link, :staff_id, :client_id, :manager_id
end
