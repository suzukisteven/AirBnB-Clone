class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :title, :description, presence: true

  # def calculate_average_rating
  #   @reviews = reviews.where(listing_id: self.id)
  #   new_average_score = @reviews.rating.sum / @reviews.rating.count
  #
  #   self.average_rating = new_average_score
  #
  #   self.save
  # end

end
