class AddBelongsToFromAppointmentToAddresses < ActiveRecord::Migration
  def change
  	add_column :appointments, :address_id, :integer
  end
end
