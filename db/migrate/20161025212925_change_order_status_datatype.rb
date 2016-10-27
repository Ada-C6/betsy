class ChangeOrderStatusDatatype < ActiveRecord::Migration
  def change
    change_column :orders, :order_status, :string
  end
end
