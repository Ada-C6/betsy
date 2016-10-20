class Merchant < ActiveRecord::Base
  validates :email, :user_name, :uid, :provider, presence: true
  has_many :products

  def self.build_from_github(auth_hash)
    merchant       = Merchant.new
    merchant.uid   = auth_hash[:uid]
    merchant.provider = 'github'
    merchant.user_name  = auth_hash['info']['nickname']
    merchant.email = auth_hash['info']['email']
    return merchant
  end
end
