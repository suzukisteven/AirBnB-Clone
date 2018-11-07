class BookingsController < ApplicationController

  # after_initialize do
  #   if self.new_record?
  #     self.payment_status ||= :pending
  #   end
  # end

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.new(booking_params)
    @booking.listing_id = @listing.id
    @booking.user_id = current_user.id
    if @booking.user_id != @listing.user_id
      if @booking.save
        @booking.pending!
        flash[:success] = "Successfully requested a booking. Please pay in 'My Profile' to secure your booking."
        redirect_to listing_path(@listing.id)
      else
        flash[:error] = "Your booking was not successful because: #{@booking.errors.full_messages[0].downcase}"
        redirect_to listing_path(@listing.id)
      end
    else
      flash[:error] = "You can't place a booking on your own listing!"
      redirect_to listing_path(@listing.id)
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      redirect_to profile_path
    end
  end

  private
  def booking_params
    params.permit(:check_in, :check_out, :guests_count, :listing_id, :user_id)
  end

end
