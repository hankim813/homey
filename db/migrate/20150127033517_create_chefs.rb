class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
    	t.string :cuisine
    	t.integer :serving_size

      t.timestamps null: false
    end
  end
end
