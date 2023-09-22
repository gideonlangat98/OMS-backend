class Event < ApplicationRecord

    belongs_to :staff, optional: true
    
    validate :validate_documents_format
    
    mount_uploader :documents, AvatarUploader

    private
    
    def validate_documents_format
        return unless documents.present?
        errors.add(:documents, "Invalid file format") unless documents.file.extension.in?(%w(jpg jpeg png pdf docx txt mp4 avi mov))
    end

end
