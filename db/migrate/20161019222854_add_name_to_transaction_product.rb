class AddNameToTransactionProduct < ActiveRecord::Migration
  def change
    add_column :transaction_products, :merchant_name, :string
    remove_column :transaction_products, :merchant_first_name, :string
    remove_column :transaction_products, :merchant_last_name, :string
  end
end
