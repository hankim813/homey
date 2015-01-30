class AddColumnsToCar < ActiveRecord::Migration
  def change
  	add_column :cars, :hours, :integer, precision: 5, scale: 2
  	add_column :cars, :driver_id, :integer
  end
end
