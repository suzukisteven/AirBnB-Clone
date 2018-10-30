class ListingsController < ApplicationController
    before_action :require_login

    def index
      @listings = Listing.all.order(:id)
    end

    def create
      @listing = Listing.new(listing_params)
      @listing.user_id = current_user.id
      if @listing.save
        redirect_to listings_path
      end
    end

    def edit
      @listing = Listing.find(params[:id])
    end

    def update
      @listing = Listing.find(params[:id])
      @listing.update(listing_params)
      if @listing.save
        redirect_to listings_path
      else
        redirect_to listings_path
      end
    end

    def destroy
      @listing = Listing.find(params[:id])
      if @listing.destroy
        redirect_to listings_path
      else
        redirect_to listings_path
      end
    end

    private
    def listing_params
      params.require(:listing).permit(:title, :description, :amenities, :price)
    end
end
