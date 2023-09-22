class CompanyArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :date, :content, :staff_id
  
  belongs_to :staff, optional: true
end
