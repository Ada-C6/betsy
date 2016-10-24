class RenameTotalColumnInOrderItemsTable < ActiveRecord::Migration
    def change
        rename_column(:order_items, :total, :total_price)
    end
end
