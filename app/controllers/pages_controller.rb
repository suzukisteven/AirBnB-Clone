class PagesController < ApplicationController

  def index
    @title = "Welcome to ScamBnB"
    @description = "\"Bring everything, leave with nothing\""
    @listings = Listing.all.order(:id)
  end

end
