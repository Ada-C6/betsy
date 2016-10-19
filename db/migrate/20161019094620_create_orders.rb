class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.string :status
      t.datetime :date_purchased
      t.string :email
      t.string :address
      t.string :cc_name
      t.integer :cc_number
      t.integer :cc_exp_year
      t.integer :cc_exp_month
      t.integer :billing_zip
      t.integer :total

      t.timestamps null: false
    end
  end
end
