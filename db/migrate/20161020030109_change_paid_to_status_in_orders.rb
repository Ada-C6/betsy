class ChangePaidToStatusInOrders < ActiveRecord::Migration
  def change
    remove_column(:orders, :paid)
    add_column(:orders, :status, :string)

  end
end
