class RemoveUidProviderFromMerchants < ActiveRecord::Migration
  def change
    remove_column(:merchants, :uid)
    remove_column(:merchants, :provider)
  end
end
