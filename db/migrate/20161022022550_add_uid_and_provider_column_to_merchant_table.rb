class AddUidAndProviderColumnToMerchantTable < ActiveRecord::Migration
  def change
    add_column :merchants, :uid, :string #null: false # this is the identifier provided by Github
    add_column :merchants, :provider, :string #null: false # this tells us who provided the identifier
  end
end
