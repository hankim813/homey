class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
    	t.belongs_to :appointment
      t.decimal :quote, scale: 2, precision: 8
    	t.integer :serviceable_id
    	t.string :serviceable_type
    	t.text :notes

      t.timestamps null: false
    end
  end
end
