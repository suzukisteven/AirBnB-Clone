class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validate :check_overlap_dates
  validate :check_guest_count

  def check_overlap_dates

    current_booking = Booking.where(listing_id: self.listing.id)
    current_booking.each do |booking|

      if (self.check_in..self.check_out).overlaps?(booking.check_in..booking.check_out) && booking != self
        errors.add(:check_in, "already has a pre-existing booking in this range.")
      end
    end
  end

  def check_guest_count
    listing = Listing.find(self.listing_id)
    if self.guests_count > listing.maximum_guests
      errors.add(:guests_count, "can't exceed maximum guests of listing.")
    end
  end
end
