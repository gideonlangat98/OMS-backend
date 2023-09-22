class Project < ApplicationRecord
  belongs_to :client, optional: true
  has_many :tasks
  has_many :staffs, through: :tasks
end
