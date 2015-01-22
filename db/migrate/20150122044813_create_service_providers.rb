class CreateServiceProviders < ActiveRecord::Migration
  def change
    create_table :service_providers do |t|
      t.string :first_name
      t.string :last_name
      t.string :birthday
      t.integer :gender
      t.string :service
      t.integer :years_experience
      t.string :phone
      t.string :address
      t.string :email
      t.string :password_hash

      t.timestamps null: false
    end
  end
end
