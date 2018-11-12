class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validate :check_overlap_dates
  validate :check_guest_count
  validates :check_in, :check_out, :guests_count, presence: true

  enum payment_status: [:pending, :paid]

  def check_overlap_dates

    current_booking = Booking.where(listing_id: self.listing.id)
    current_booking.each do |booking|

      if (self.check_in..self.check_out).overlaps?(booking.check_in..booking.check_out) && booking != self
        errors.add(:check_in, "already has a booking in this date range.")
      end
    end
  end

  def check_guest_count
    listing = Listing.find(self.listing_id)
    if self.guests_count > listing.maximum_guests
      errors.add(:guests_count, "can't exceed maximum guests of listing.")
    end
  end

  def total_price
    # To be more explicit, use self keyword to reference the current object itself.
    self.listing.price_per_night * (self.check_out - self.check_in).to_i

    # [T] This works too:
    # listing.price_per_night (check_out - check_in).to_i)
  end

end
