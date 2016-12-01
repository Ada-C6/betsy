class ReAddForeignKeysOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :user_id, :integer
  	add_column :orders, :product_id, :integer
  end
end
