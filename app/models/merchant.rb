class Merchant < ActiveRecord::Base
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  validates :uid, :provider, presence: true

  def self.build_from_google(auth_hash)
    user       = Merchant.new
    user.uid   = auth_hash[:uid]
    user.provider = 'google'
    user.name  = auth_hash['info']['name']
    user.email = auth_hash['info']['email']

    return user
  end

end
