class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.string :birthday
      t.string :email
      t.string :phone
      t.integer :authorization_level
      t.string :password_hash

      t.timestamps null: false
    end
  end
end
