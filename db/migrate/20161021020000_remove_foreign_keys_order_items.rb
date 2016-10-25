class RemoveForeignKeysOrderItems < ActiveRecord::Migration
  def change
  	remove_column :order_items, :order_id_id
  	remove_column :order_items, :product_id_id
  end
end
