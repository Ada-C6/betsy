class AddAddressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address_id, :integer
    add_column :orders, :billing_address_id, :integer
  end
end
  
