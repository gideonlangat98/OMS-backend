class ProgressSerializer < ActiveModel::Serializer
  attributes :id, :progress_by, :project_managed, :assignment_name, :granted_time, :task_managed, :assigned_date, :start_date, :exceeded_by, :delivery_time, :staff_id

  belongs_to :staff
end
