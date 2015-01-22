class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
    	t.belongs_to :user
    	t.datetime :service_date
    	t.boolean :completed, default: false
    	t.boolean :paid, default: false

      t.timestamps null: false
    end
  end
end
