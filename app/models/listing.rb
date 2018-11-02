class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :user
  validates :title, :description, presence: true
end
