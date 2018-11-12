class EditListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :address, :string
    add_column :listings, :availability_from, :date
    add_column :listings, :availability_to, :date
    add_column :listings, :maximum_guests, :integer
    add_column :listings, :home_type, :string
    add_column :listings, :room_type, :string
    add_column :listings, :price_per_night, :decimal

    remove_column :listings, :price, :integer
    remove_column :listings, :amenities, :string
  end
end
