class MakeLongIntegersStrings < ActiveRecord::Migration
  def change
    remove_column :orders, :card_number, :integer
    add_column :orders, :card_number, :string

    remove_column :orders, :card_cvv, :integer
    add_column :orders, :card_cvv, :string

    remove_column :orders, :billing_zip, :integer
    add_column :orders, :billing_zip, :string

    remove_column :orders, :shipping_zip, :integer
    add_column :orders, :shipping_zip, :string
  end
end
