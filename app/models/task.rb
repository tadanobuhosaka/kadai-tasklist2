class Task < ApplicationRecord
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 100 }
  
  belongs_to :user
  
end
