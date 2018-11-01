class ListingsController < ApplicationController
    before_action :require_login
    before_action :check_user, only: [:edit, :update, :destroy]
    before_action :check_role, only: [:verify]

    def index
      p params[:page]
      @listings = Listing.all.order(:id)
      @listingsPerPage = 10
      @listingsCount = Listing.all.count
      @paginate_count = (@listings.count/8).to_i
        # byebug
      if params[:page] == 1
        @listings = @listings.first(10)
      end
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

    def verify
      @listing = Listing.find(params[:id])
      if @listing.verified
        @listing.update(verified: false)

      else
        @listing.update(verified: true)
      end
      if @listing.save
        flash[:success] = "Verifed/Unverified"
        redirect_to listings_path
      else
          flash[:error] = "Failed to verify/unverify"
          redirect_back(fallback_url: listings_path)
      end
    end

    private
    def listing_params
      params.require(:listing).permit(:title, :description, :amenities, :price)
    end

    def check_user
      @listing = Listing.find(params[:id])
      if current_user.id != @listing.user_id || current_user.moderator?
        redirect_to listings_path
      end
    end

    def check_role
      if current_user.customer?
        redirect_to listings_path
      end
    end
end
