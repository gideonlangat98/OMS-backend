class CompanyArticle < ApplicationRecord
    belongs_to :staff, optional: true
    validates :title, presence: true
    validates :date, presence: true
    validates :content, presence: true
end
