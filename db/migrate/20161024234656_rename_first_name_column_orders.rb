class RenameFirstNameColumnOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :first_name, :name
  end
end
