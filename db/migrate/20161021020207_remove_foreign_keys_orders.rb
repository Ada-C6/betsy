class RemoveForeignKeysOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :user_id_id
  	remove_column :orders, :product_id_id
  end
end
