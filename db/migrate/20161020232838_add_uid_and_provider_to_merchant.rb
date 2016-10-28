class AddUidAndProviderToMerchant < ActiveRecord::Migration
  def change
    add_column(:merchants, :uid, :string)
    add_column(:merchants, :provider, :string)
  end
end
