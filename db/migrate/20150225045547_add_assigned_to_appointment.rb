class AddAssignedToAppointment < ActiveRecord::Migration
  def change
  	add_column :appointments, :assigned, :boolean, default: false
  end
end
