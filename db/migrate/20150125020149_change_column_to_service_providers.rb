class ChangeColumnToServiceProviders < ActiveRecord::Migration
  def up
    remove_column :service_providers, :birthday
    add_column :service_providers, :birthday, :date
  end

  def down
    remove_column :service_providers, :birthday
    add_column :service_providers, :birthday, :string
  end
end
