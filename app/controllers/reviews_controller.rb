class ReviewsController < ApplicationController

  def index
  end

  def create
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
