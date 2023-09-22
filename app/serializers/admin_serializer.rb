class AdminSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :password_digest, :isadmin

  has_many :staffs
  has_many :forms, through: :staffs
end
