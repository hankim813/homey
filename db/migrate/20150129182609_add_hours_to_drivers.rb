class AddHoursToDrivers < ActiveRecord::Migration
  def change
  	add_column :drivers, :hours, :float, precision: 5, scale: 2
  end
end
