class PagesController < ApplicationController

  def index
    @title = "Welcome to ScamBnB"
    @description = "Bring everything. Leave with nothing."
    p params[:page]
    @listings = Listing.all.order(:id)
    @paginate_count = (@listings.count/8).to_i
    if params[:page]
      multiplier = params[:page].to_i - 1
      start = multiplier * 8
      @listings = @listings[start...start+8]
    else
      @listings
    end
  end

end
