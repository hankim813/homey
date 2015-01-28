class CreateSecurities < ActiveRecord::Migration
  def change
    create_table :securities do |t|

      t.timestamps null: false
    end
  end
end
