class OrdersTableAddDefaultToStatus < ActiveRecord::Migration
  def change
      change_column(:orders, :status, :string, :default => "PENDING")
  end
end
