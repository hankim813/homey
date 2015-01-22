class ChangeColumnDefaultValueForAppointments < ActiveRecord::Migration
  def change
  	change_column :appointments, :canceled, :boolean, default: false
  end
end
