class ChangeProviderColumn < ActiveRecord::Migration
  def change
    change_column :merchants, :provider, :string
  end
end
