class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :username
      t.string :email
      t.integer :uid
      t.string :provider
      t.string :displayname

      t.timestamps null: false
    end
  end
end
