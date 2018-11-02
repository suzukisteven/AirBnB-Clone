class UpdateListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :country, :string
    add_column :listings, :street_address, :string
    add_column :listings, :room_number, :string
    add_column :listings, :city, :string
    add_column :listings, :state, :string
    add_column :listings, :zip_code, :integer
    add_column :listings, :beds, :integer
    add_column :listings, :bathrooms, :integer
    add_column :listings, :property_type, :string
    add_column :listings, :amenities, :string
    add_column :listings, :shared_spaces, :string

    remove_column :listings, :address, :string
    remove_column :listings, :room_type, :string
  end
end
