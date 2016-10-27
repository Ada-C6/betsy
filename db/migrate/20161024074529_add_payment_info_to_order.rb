class AddPaymentInfoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :cc_number, :integer
    add_column :orders, :exp_month, :integer
    add_column :orders, :exp_year, :integer
    add_column :orders, :cvc, :integer
  end
end
