class AddColumnToAppointments < ActiveRecord::Migration
  def change
  	add_column :appointments, :canceled, :boolean
  end
end
