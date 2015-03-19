class CreatePasswordTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :passkey

      t.timestamps null: false
    end
  end
end