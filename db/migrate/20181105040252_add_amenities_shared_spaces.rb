class AddAmenitiesSharedSpaces < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :amenities, :string, array: true, default: []
    add_column :listings, :shared_spaces, :string, array: true, default: []
  end
end
