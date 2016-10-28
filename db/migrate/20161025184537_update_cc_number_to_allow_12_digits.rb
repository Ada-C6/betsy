class UpdateCcNumberToAllow12Digits < ActiveRecord::Migration
  def change
    change_column(:orders, :cc_number, :integer, limit: 6)
  end
end
