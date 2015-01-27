class AddTimeToBookings < ActiveRecord::Migration
  def change
  	add_column :bookings, :time_required, :integer
  end
end
