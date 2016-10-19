class RemovePasswordFromMerchants < ActiveRecord::Migration
  def change
    remove_column(:merchants, :password)
  end
end
