class Listing < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :title, :description, presence: true
  mount_uploaders :images, ListingsImageUploader

  scope :title, -> (title) { where title: title}
  scope :country, -> (country) {where country: country}
  scope :city, -> (city) {where city: city}
  scope :beds, -> (beds) {where beds: beds}
  scope :bathrooms, -> (bathrooms) {where bathrooms: bathrooms}
  scope :amenities, -> (amenities) {where amenities: amenities}
  scope :property_type, -> (property_type) {where property_type: property_type}
  scope :price_per_night, -> (price_per_night) {where price_per_night: price_per_night}
  scope :maximum_guests, -> (maximum_guests) {where maximum_guests: maximum_guests}
  scope :multi, -> (values) { where("title iLike ? OR country iLike ? OR city iLike ? OR property_type iLIKE ?", "#{values}%", "#{values}%", "#{values}%", "#{values}%")}
end
