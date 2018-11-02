class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :guests_count
      t.date :check_in
      t.date :check_out

      t.belongs_to :users, :listings

      t.timestamps
    end
  end
end
