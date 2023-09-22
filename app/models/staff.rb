class Staff < ApplicationRecord
  require "securerandom"
  has_secure_password


  belongs_to :admin, optional: true
  belongs_to :manager, optional: true
  has_many :requests
  has_many :progresses
  has_many :forms
  has_many :leave_types
  has_many :leave_calculations, dependent: :destroy
  has_many :tasks
  has_many :projects, through: :tasks
  has_many :timesheets
  has_many :company_articles
  has_many :check_in_outs
  has_many :events
  has_one :profile

  has_many :sent_messages, class_name: 'Message', foreign_key: 'staff_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'admin_id'

  validates :staff_name, presence: true
  validates :joining_date, presence: true
  validates :reporting_to, presence: true
  validates :designation, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
