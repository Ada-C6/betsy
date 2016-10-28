class ChangeDataTypeForCcExpiration < ActiveRecord::Migration
  def change
    change_column :payment_details, :cc_expiration_date, :datetime
  end
end
