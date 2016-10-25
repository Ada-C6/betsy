class ReAddIndicesOrders < ActiveRecord::Migration
  def change
  	add_index :orders, :user_id
  	add_index :orders, :product_id
  end
end
