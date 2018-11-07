class BraintreeController < ApplicationController

  before_action :checkout_params, only: [:new, :show, :checkout, :edit, :update, :destroy]

  def new
    @client_token = Braintree::ClientToken.generate
    @user = current_user
    @booking = Booking.find(checkout_params[:booking_id])
    @listing = Listing.find(@booking.listing_id)
  end

  def checkout
    #@paid = false
    @booking = Booking.find(checkout_params[:booking_id])
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

  result = Braintree::Transaction.sale(
   :amount => @booking.total_price, #this is currently hardcoded - "10"
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

    if result.success?
      @booking.paid!
      redirect_to :root, :flash => { :success => "Transaction Successful. Thank you for booking with ScamBnB." }
    else
      redirect_to :root, :flash => { :error => "Transaction was unsuccessful. Please try again." }
    end
  end

  private
  def checkout_params
    params.permit(:booking_id)
  end
end
