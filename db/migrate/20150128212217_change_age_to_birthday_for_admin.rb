class ChangeAgeToBirthdayForAdmin < ActiveRecord::Migration
  def up
    remove_column :admins, :birthday
    add_column :admins, :birthday, :date
  end

  def down
    remove_column :admins, :birthday
    add_column :admins, :birthday, :string
  end
end
