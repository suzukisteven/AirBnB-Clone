class ReservationMailer < ApplicationMailer

  default from: "from@example.com"

  def booking_email (customer, host, booking_id)
    @customer = customer
    @host = host
    @booking_id = booking_id
    @booking = Booking.find(booking_id)
    @listing = Listing.find(@booking.listing_id)
    mail(to: 'suzukisteven@gmail.com', subject: "Congratulations! Your place has been booked!")
  end
end
