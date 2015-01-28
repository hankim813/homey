class Admin < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.first_name :string
      t.last_name :string
      t.gender :string
      t.birthday :date
      t.email :string
      t.phone :string
      t.authorization_level :integer
      t.password_hash :string

      t.timestamps null: false
    end
  end
end