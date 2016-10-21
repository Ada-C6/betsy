class AddUnitPriceToOrderItemsTable < ActiveRecord::Migration
    def change
        add_column(:order_items, :unit_price, :integer)
        add_column(:order_items, :total, :integer)
    end
end
