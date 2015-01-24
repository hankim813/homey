class AddColumnToBookings < ActiveRecord::Migration
  def change
  	add_column :bookings, :num_of_providers, :integer
  end
end
