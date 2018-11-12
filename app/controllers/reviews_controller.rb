class ReviewsController < ApplicationController

  def index
  end

  def new
    @reviews = Review.all.order(created_at: :desc)
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @review = Review.new(review_params)
    @review.listing_id = @listing.id
    @review.user_id = current_user.id
    if @review.user_id != @listing.user_id
      if @review.save
        flash[:success] = "Your review was successfully created."
        redirect_to listing_path(@listing.id)
      else
        flash[:error] = "Failed to create your review."
        redirect_to listing_path(@listing.id)
      end
    else
      flash[:error] = "You can't review your own listing!"
      redirect_to listing_path(@listing.id)
    end
  end

  def show
  end

  def destroy
  end

  private
  def review_params
    params.permit(:comment, :rating, :listing_id, :user_id)
  end

end
