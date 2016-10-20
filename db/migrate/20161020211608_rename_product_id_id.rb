class RenameProductIdId < ActiveRecord::Migration
  def change
    rename_column :order_items, :product_id_id, :product_id
    rename_column :order_items, :order_id_id, :order_id

    rename_column :orders, :product_id_id, :product_id
    rename_column :orders, :user_id_id, :user_id

    rename_column :products, :user_id_id, :user_id

    rename_column :reviews, :user_id_id, :user_id

  end
end
