class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :channel, :admin_id, :staff_id, :read, :sender_type, :created_at, :updated_at
end
