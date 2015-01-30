class RemoveDayOrNightColumnFromDrivers < ActiveRecord::Migration
  def change
  	remove_column :drivers, :day_or_night
  end
end
