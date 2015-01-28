class CreateGardenings < ActiveRecord::Migration
  def change
    create_table :gardenings do |t|
    	t.float :acres
    	t.integer :type

      t.timestamps null: false
    end
  end
end
