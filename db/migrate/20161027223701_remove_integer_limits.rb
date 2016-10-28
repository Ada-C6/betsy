class RemoveIntegerLimits < ActiveRecord::Migration
  def change
    change_column :orders, :phone, :integer, limit: nil
    change_column :users, :phone, :integer, limit: nil
  end
end
