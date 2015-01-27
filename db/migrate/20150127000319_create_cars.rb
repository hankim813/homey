class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
    	t.belongs_to :driver
    	t.string :model
    	t.integer :wheel_type

      t.timestamps null: false
    end
  end
end
