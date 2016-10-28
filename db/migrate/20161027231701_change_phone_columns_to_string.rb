class ChangePhoneColumnsToString < ActiveRecord::Migration
  def change
    change_column :users, :phone, :string
    change_column :orders, :phone, :string
  end
end
