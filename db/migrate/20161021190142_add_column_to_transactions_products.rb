class AddColumnToTransactionsProducts < ActiveRecord::Migration
  def change
  	add_column :transaction_products, :product_id, :integer
  	add_column :transaction_products, :transaction_id, :integer
  end
end
