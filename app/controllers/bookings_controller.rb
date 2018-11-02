class BookingsController < ApplicationController

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.new(booking_params)
    @booking.listing_id = @listing.id
    @booking.user_id = current_user.id
    if @booking.save
      flash[:success] = "Successfully requested a booking. Your host will contact you shortly."
      redirect_to listings_path(@listing.id)
    else
      flash[:error] = "Your booking was not successfully made because #{@booking.errors.full_messages[0].downcase}"
      redirect_to listings_path
    end
  end

  private
  def booking_params
    params.permit(:check_in, :check_out, :guests_count, :listing_id, :user_id)
  end

end
