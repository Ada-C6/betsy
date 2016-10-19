class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :user_name
      t.string :email
      t.integer :uid, null: false
      t.string :provider, null: false
      t.timestamps null: false
    end
  end
end
