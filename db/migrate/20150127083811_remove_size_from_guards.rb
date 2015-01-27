class RemoveSizeFromGuards < ActiveRecord::Migration
  def change
  	remove_column :guards, :size
  end
end
