class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :amenities, null: false
      t.integer :price, null: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
