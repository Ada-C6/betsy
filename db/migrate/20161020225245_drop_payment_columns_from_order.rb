class DropPaymentColumnsFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :buyer_name
    remove_column :orders, :email
    remove_column :orders, :street
    remove_column :orders, :city
    remove_column :orders, :state
    remove_column :orders, :zip
    remove_column :orders, :cc_four_digits
    remove_column :orders, :cc_expiration_date
    remove_column :orders, :time_placed
    remove_column :orders, :shipped

  end
end
