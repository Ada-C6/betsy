class AddMerchantIdColumnToTransactionProduct < ActiveRecord::Migration
  def change
    add_column :transaction_products, :merchant_id, :integer
  end
end
