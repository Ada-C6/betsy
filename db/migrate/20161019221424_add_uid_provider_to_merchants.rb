class AddUidProviderToMerchants < ActiveRecord::Migration
  def change
    add_column(:merchants, :uid, :integer)
    change_column_default(:merchants, :uid, from: false, to: true)
    add_column(:merchants, :provider, :string)
    change_column_default(:merchants, :provider, from: false, to: true)
  end
end
