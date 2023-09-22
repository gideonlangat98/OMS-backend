class Manager < ApplicationRecord
    require "securerandom"
    has_secure_password

    has_many :staffs

    validates :f_name, presence: true
    validates :l_name, presence: true
    validates :managers_title, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6}

end
