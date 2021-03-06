class Project < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :name, presence: true,
                    length: { minimum: 3 }
    belongs_to :user
    
end
