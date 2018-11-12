class ChangePaymentStatusType < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :payment_status, :string

    add_column :bookings, :payment_status, :integer
  end
end
