class ProgressSerializer < ActiveModel::Serializer
  attributes :id, :progress_by, :project_managed, :task_managed, :assigned_date, :start_date, :exceeded_by, :delivery_time, :staff_id

  belongs_to :staff, optional: true
end
