class ChangeCcExpDateToDatetimeOrdersTable < ActiveRecord::Migration
  def change
    change_column :orders, :cc_expiration_date, :datetime
  end
end
