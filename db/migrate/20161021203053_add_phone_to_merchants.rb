class AddPhoneToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :phone, :string
  end
end
