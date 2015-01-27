class AddPrecisionToFloatColumns < ActiveRecord::Migration
  def change
  	change_column :bookings, :time_required, :float, precision: 5, scale: 2
  	change_column :gardenings, :acres, :float, precision: 4, scale: 2
  end
end
