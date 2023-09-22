class Admin < ApplicationRecord
    require "securerandom"
    has_secure_password
  
    has_many :staffs
    has_many :forms, through: :staffs
    has_many :sent_messages, class_name: 'Message', foreign_key: 'admin_id'
    has_many :received_messages, class_name: 'Message', foreign_key: 'staff_id'
  
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
  end
  