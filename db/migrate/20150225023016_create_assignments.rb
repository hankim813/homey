class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
    	t.belongs_to :service_provider
    	t.belongs_to :appointment
      t.timestamps null: false
    end
  end
end
