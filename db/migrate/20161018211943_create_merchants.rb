class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps null: false
    end
  end
end
