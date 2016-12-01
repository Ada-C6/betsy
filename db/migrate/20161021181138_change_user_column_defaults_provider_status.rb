class ChangeUserColumnDefaultsProviderStatus < ActiveRecord::Migration
  def change
  	change_column_default(:users, :provider, :false)
  end
end
