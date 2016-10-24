class ChangeStatusDataTypeInOrder < ActiveRecord::Migration
  def change
    change_column(:orders, :status, :string, limit: 80)
  end
end
