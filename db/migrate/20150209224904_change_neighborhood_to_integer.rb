class ChangeNeighborhoodToInteger < ActiveRecord::Migration
  def up
  	remove_column :addresses, :neighborhood
  	add_column :addresses, :neighborhood, :integer
  end

  def down
  	remove_column :addresses, :neighborhood
  	add_column :addresses, :neighborhood, :string
  end
end
