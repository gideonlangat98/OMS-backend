class Profile < ApplicationRecord
    belongs_to :staff
  
    validates :bio, length: { maximum: 500 }
    validate :validate_avatar_format
  
    mount_uploader :avatar, AvatarUploader
  
    private
  
    def validate_avatar_format
      return unless avatar.present?
      errors.add(:avatar, "Invalid file format") unless avatar.file.extension.in?(%w(jpg jpeg png))
    end
  end
  