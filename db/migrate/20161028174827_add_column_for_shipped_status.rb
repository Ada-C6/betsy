class AddColumnForShippedStatus < ActiveRecord::Migration
  def change
    add_column(:order_items, :shipped, :boolean, :default => false)
  end
end
