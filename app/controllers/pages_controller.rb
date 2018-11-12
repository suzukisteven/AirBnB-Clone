class PagesController < ApplicationController

  def index

    @title = "ScamBnB"
    @description = "Bring everything, Leave with nothing."
    @listings = Listing.all.order(created_at: :desc)
    @paginate_count = (@listings.count/8).to_i
    # p params[:page]

    if params[:page]
      multiplier = params[:page].to_i - 1
      start = multiplier * 8
      @listings = @listings[start...start+8]
    else
      @listings
    end

  end

end
