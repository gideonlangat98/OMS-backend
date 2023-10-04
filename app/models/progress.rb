class Progress < ApplicationRecord
    belongs_to :staff, optional: true
  
    enum progress_sender: { staff: 'staff' }
  
    validates :seen, inclusion: { in: [true, false] }
    after_initialize :set_default_read_flag
    
    def set_default_read_flag
        self.seen ||= false
    end
  
    # Add the read attribute
    attribute :seen, :boolean, default: false
  end
  