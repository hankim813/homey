class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
    	t.string :model
    	t.integer :wheel_type
    	t.integer :day_or_night
    	t.boolean :owned

      t.timestamps null: false
    end
  end
end
