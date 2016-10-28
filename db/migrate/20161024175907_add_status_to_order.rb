class AddStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status, :string, default: "in progress"
  end
end
