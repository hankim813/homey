class RemovePhoneFromAddress < ActiveRecord::Migration
  def change
  	remove_column :addresses, :phone
  end
end
