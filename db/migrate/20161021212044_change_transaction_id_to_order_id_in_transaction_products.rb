class ChangeTransactionIdToOrderIdInTransactionProducts < ActiveRecord::Migration
  def change
    rename_column :transaction_products, :transaction_id, :order_id
  end
end
