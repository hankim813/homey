class AddColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :gender, :integer
  	add_column :users, :age, :integer
  	add_column :users, :email, :string
  	add_column :users, :phone, :string
  end
end
