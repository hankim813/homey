class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
    	t.integer :day_or_night

      t.timestamps null: false
    end
  end
end
