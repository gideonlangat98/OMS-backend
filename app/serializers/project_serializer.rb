class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :project_name, :description, :client_details, :project_managers, :task_managers, :client_id

  belongs_to :client
  has_many :tasks
  has_many :staffs, through: :tasks
end
