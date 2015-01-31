class CreateRedemptions < ActiveRecord::Migration
  def change
    create_table :redemptions do |t|
    	t.belongs_to :user
    	t.belongs_to :discount

      t.timestamps null: false
    end
  end
end
