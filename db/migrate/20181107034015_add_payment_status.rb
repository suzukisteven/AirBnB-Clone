class AddPaymentStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :payment_status, :string
  end
end
