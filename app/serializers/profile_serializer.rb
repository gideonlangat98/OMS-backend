class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :bio, :avatar, :about, :location,:bio_name, :my_email, :tech, :staff_id

  belongs_to :staff
end
