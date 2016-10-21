class CreateAddColumnsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :client_name, :string
    add_column :transactions, :client_cc_exp, :string
  end
end
