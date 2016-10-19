class AddPasswordToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :password, :string
  end
end
