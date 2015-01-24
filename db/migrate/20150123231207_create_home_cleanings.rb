class CreateHomeCleanings < ActiveRecord::Migration
  def change
    create_table :home_cleanings do |t|
    	t.integer :bedrooms
    	t.integer :bathrooms
    	t.integer :kitchens
    	t.integer :livingrooms

      t.timestamps null: false
    end
  end
end
