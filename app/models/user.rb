class User < ActiveRecord::Base
  has_many :reviews
  has_many :products
  has_many :orders
  # has_secure_password

  validates :email, :uid, :provider, presence: true

  def self.build_from_github(auth_hash)
    user       = User.new
    user.uid   = auth_hash[:uid]
    user.provider = 'github'
    user.name  = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    #raise to get info for auth hash
    return user
  end
end
