class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :mailing_address
      t.string :cc_last_4 #We can validate this as four number digits
      t.date :cc_expire
      t.datetime :purchase_time
      t.string :status
      
      t.timestamps null: false
    end
  end
end
