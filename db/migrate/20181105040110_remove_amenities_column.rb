class RemoveAmenitiesColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :listings, :amenities, :string
    remove_column :listings, :shared_spaces, :string
  end
end
