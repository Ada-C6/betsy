class AddLineItemPricetoOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :line_item_price, :integer
  end
end
