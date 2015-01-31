class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
    	t.string :code
    	t.integer :percentage, scale: 2
    	t.integer :times_redeemed
    	t.belongs_to :admin

      t.timestamps null: false
    end
  end
end
