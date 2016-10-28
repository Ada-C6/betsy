class AddGithubProvierColumns < ActiveRecord::Migration
  def change
    add_column(:merchants, :uid, :integer, null: false, default: 0)
    add_column(:merchants, :provider, :string, null: false, default: "github")
  end
end
