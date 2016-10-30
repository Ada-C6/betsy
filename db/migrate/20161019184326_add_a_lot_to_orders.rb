class AddALotToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :email, :string
    add_column :orders, :street_address, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :mailing_zip, :string
    add_column :orders, :cc_number, :string
    add_column :orders, :cc_exp_month, :integer
    add_column :orders, :cc_exp_year, :integer
    add_column :orders, :cc_sec_code, :integer
    add_column :orders, :billing_zip, :string
    add_column :orders, :order_status, :boolean
    add_column :orders, :time_placed, :datetime
  end
end
