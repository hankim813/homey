class AddColumnsToDiscounts < ActiveRecord::Migration
  def change
  	add_column :discounts, :limit, :integer
  	add_column :discounts, :reusable, :boolean
  end
end
