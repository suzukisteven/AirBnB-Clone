class AddVerifiedDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :verified, :boolean, :default => false
  end
end
