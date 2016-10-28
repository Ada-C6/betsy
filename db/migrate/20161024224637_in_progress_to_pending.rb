class InProgressToPending < ActiveRecord::Migration
  def change
    change_column_default(:orders, :status, "pending")
  end
end
