class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
    	t.integer :type
    	t.text :problem_description
    	t.text :problem_frequency

      t.timestamps null: false
    end
  end
end
