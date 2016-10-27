class RemoveLastNameFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :last_name
  end
end
