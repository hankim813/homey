class CreateOfficeCleanings < ActiveRecord::Migration
  def change
    create_table :office_cleanings do |t|
    	t.integer :sqft

      t.timestamps null: false
    end
  end
end
