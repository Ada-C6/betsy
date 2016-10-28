class ChangePhoneLimitToUser < ActiveRecord::Migration
  def change
    change_column :users, :phone, :integer, limit: 10
  end
end
