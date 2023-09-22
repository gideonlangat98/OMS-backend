class ManagerSerializer < ActiveModel::Serializer
  attributes :id, :f_name, :l_name, :managers_title, :email, :password_digest

  has_many :staffs
end
