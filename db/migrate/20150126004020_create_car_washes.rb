class CreateCarWashes < ActiveRecord::Migration
  def change
    create_table :car_washes do |t|
    	t.integer :cars
    	t.boolean :water_provided

      t.timestamps null: false
    end
  end
end
