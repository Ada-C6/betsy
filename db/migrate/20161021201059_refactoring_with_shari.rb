class RefactoringWithShari < ActiveRecord::Migration
  def change
      remove_column(:order_items, :unit_price)
      remove_column(:order_items, :total_price)
  end
end
