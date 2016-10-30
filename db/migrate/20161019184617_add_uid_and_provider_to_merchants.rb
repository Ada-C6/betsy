class AddUidAndProviderToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :uid, :integer
    add_column :merchants, :provider, :integer

  end
end
