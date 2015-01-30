class RemoveHoursFromDrivers < ActiveRecord::Migration
  def change
  	remove_column :drivers, :hours
  end
end
