class ChangeColumnToBookingForTimeRequired < ActiveRecord::Migration
  def change
  	change_column :bookings, :time_required, :float
  end
end
