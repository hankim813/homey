class AddKitchenToOffice < ActiveRecord::Migration
  def change
  	add_column :office_cleanings, :kitchen, :boolean
  end
end
