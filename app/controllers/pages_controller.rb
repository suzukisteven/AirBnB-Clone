class PagesController < ApplicationController

  def index
    @title = "Welcome to ScamBnB"
    @description = "\"Bring everything, leave with nothing\""
    p params[:page]
    @listings = Listing.all.order(:id)
    @paginate_count = (@listings.count/8).to_i

    # if params[:page] == "1"
    #   @listings = @listings.first(8) # 8
    # elsif params[:page] == "2"
    #   @listings = @listings[9..16]
    # elsif params[:page] == "3"
    #   @listings = @listings[17...24]
    # else
    #   @listings
    # end
    if params[:page]
      multiplier = params[:page].to_i - 1
      start = multiplier * 8
      @listings = @listings[start...start+8]
    else
      @listings
    end
  end

end
