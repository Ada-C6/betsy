class ChangePhoneLimitToOrder < ActiveRecord::Migration
  def change
    change_column :orders, :phone, :integer, limit: 10
  end
end
