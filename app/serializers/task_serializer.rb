class TaskSerializer < ActiveModel::Serializer
  attributes :id, :assignment_date, :task_name, :assigned_to, :task_manager, :project_manager, :project_name, :task_deadline, :send_type, :avatar_image, :completed_files, :project_id, :isSeen, :staff_id

  belongs_to :project
  has_many :timesheets
  belongs_to :staff

end
