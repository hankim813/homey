class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.string :building_name
    	t.string :street
    	t.string :po_box
    	t.string :neighborhood
    	t.string :phone
    	t.belongs_to :user

      t.timestamps null: false
    end
  end
end
