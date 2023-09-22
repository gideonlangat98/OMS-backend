class Task < ApplicationRecord
  belongs_to :project, optional: true
  has_many :timesheets
  belongs_to :staff, optional: true

  validate :validate_avatar_image_format
  validate :validate_completed_files_format
  
  mount_uploader :avatar_image, AvatarUploader
  mount_uploaders :completed_files, AvatarUploader

  enum send_type: { admin: 'admin', staff: 'staff' }

  validates :send_type, presence: true

  # has_many_attached :completed_files

  serialize :completed_files, Array

  private

  def validate_avatar_image_format
    return unless avatar_image.present?
    errors.add(:avatar_image, "Invalid file format") unless avatar_image.file.extension.in?(%w(jpg jpeg png pdf docx txt mp4 avi mov))
  end

  def validate_completed_files_format
    return unless completed_files.present?
  
    completed_files.each do |file|
      file_name = File.basename(file.to_s)
      extension = File.extname(file_name).delete(".")
  
      unless %w(jpg jpeg png pdf docx txt mp4 avi mov).include?(extension)
        errors.add(:completed_files, "Invalid file format")
        break
      end
    end
  end
  
end
