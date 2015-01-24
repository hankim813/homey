class CreateLaundries < ActiveRecord::Migration
  def change
    create_table :laundries do |t|
    	t.integer :loads
    	t.integer :ironed
    	t.belongs_to :home_cleaning
    end
  end
end
