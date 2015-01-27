class CreateGuards < ActiveRecord::Migration
  def change
    create_table :guards do |t|
    	t.belongs_to :security
    	t.integer :type
    	t.integer :size
    	t.integer :hours_required

      t.timestamps null: false
    end
  end
end
