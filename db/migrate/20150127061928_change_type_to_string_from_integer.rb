class ChangeTypeToStringFromInteger < ActiveRecord::Migration
  def change
  	change_column :gardenings, :type, :string
  end
end
