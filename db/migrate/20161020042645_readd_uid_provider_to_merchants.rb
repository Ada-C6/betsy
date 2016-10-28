class ReaddUidProviderToMerchants < ActiveRecord::Migration
  def change
    
    add_column(:merchants, :uid, :integer)

    add_column(:merchants, :provider, :string)

  end
end
