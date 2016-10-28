class AddPurchasedToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :purchased, :boolean, default: false
  end
end
