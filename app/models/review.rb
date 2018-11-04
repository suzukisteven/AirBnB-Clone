class Review < ApplicationRecord

  belongs_to :user
  belongs_to :listing
  validates :comment, :score, presence: true
  
end
