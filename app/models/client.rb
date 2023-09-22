class Client < ApplicationRecord
    has_many :projects
    has_many :clients

    validates :main_email, presence: true, uniqueness: true
    validates :second_email, presence: true, uniqueness: true
end
