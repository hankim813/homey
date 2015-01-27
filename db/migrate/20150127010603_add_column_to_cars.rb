class AddColumnToCars < ActiveRecord::Migration
  def change
  	add_column :cars, :owned, :boolean
  end
end
