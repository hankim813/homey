class ChangeAgeToBirthdayForUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :age
  	add_column :users, :birthday, :date
  end

  def down
  	remove_column :users, :birthday
  	add_column :users, :age, :integer
  end
end
