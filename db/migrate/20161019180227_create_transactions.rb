class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :status
      t.integer :total_price
      t.string :client_email
      t.string :client_address
      t.string :client_cc_num

      t.timestamps null: false
    end
  end
end
