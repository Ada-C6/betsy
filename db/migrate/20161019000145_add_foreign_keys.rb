class AddForeignKeys < ActiveRecord::Migration
  def change
    remove_column :orders, :guest_id, :integer
    remove_column :orders, :merchant_id, :integer

    add_reference :orders, :guest, index: true, foreign_key: true
    add_reference :orders, :merchant, index: true, foreign_key: true

    remove_column :products, :merchant_id, :integer
    add_reference :products, :merchant, index: true, foreign_key: true

    remove_column :reviews, :product_id, :integer
    add_reference :reviews, :product, index: true, foreign_key: true
  end
end
