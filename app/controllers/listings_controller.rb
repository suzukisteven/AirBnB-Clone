class ListingsController < ApplicationController
    before_action :require_login
    before_action :set_listing, only: [:show, :edit, :update, :destroy, :verify]
    before_action :check_user, only: [:edit, :update, :destroy]
    before_action :check_role, only: [:verify]

    def index
      # Use will_paginate. don't be a masochist.
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

    def show
    end

    def create
      @listing = Listing.new(listing_params)
      @listing.user_id = current_user.id
      if @listing.save
        flash[:success] = "Successfully created a listing"
        redirect_to listings_path
      else
        @listing.errors.full_messages.each_with_index do |e,i|
          key = "error" + i.to_s
        flash[key] = e
        end
        redirect_to new_listing_path
      end
      # flash[:error0] => "title_not null"
      # flash[:error1] => "location not null"
    end

    def new
    end

    def edit
    end

    def update
      @listing.update(listing_params)
      if @listing.save
        redirect_to listings_path
      else
        redirect_to listings_path
      end
    end

    def destroy
      if @listing.destroy
        redirect_to listings_path
      else
        redirect_to listings_path
      end
    end

    def verify
      if @listing.verified
        @listing.update(verified: false)
      else
        @listing.update(verified: true)
      end
      if @listing.save
        flash[:success] = "Successfully Verifed/Unverified"
        redirect_to listings_path
      else
        flash[:error] = "Failed to verify/unverify"
        redirect_back(fallback_url: listings_path)
      end
    end

    private

    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:title, :description, :maximum_guests,
                                      :price_per_night, :home_type, :property_type,
                                      :country, :street_address, :room_number,
                                      :city, :state, :zip_code, :beds, :bathrooms,
                                      :property_type, :amenities, :shared_spaces  )
    end

    def check_user
      @listing = Listing.find(params[:id])
      if @listing.user == current_user || current_user.moderator? || current_user.superadmin?
      else
          flash[:notice] = "Unauthorized"
          redirect_to listings_path
      end
    end

    def check_role
      if current_user.customer?
        redirect_to listings_path
      end
    end
end
