class AddMultipleKeysToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address, :string
    add_column :orders, :cc_number, :string
    add_column :orders, :expiration_date, :string
    add_column :orders, :cvv, :string
    add_column :orders, :zip_code, :string
  end
end
