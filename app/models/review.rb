class Review < ApplicationRecord

  belongs_to :user
  belongs_to :listing
  validates :comment, :rating, presence: true

end
