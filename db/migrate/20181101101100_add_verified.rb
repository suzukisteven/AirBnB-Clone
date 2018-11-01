class AddVerified < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :verified, :boolean

    remove_column :listings, :availability_from, :date
    remove_column :listings, :availability_to, :date
  end
end
