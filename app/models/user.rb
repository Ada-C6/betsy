class User < ActiveRecord::Base

  validates :name,:email, :uid, :provider, presence: true

  has_many :transactions #this may need to be changed
  has_many :reviews
  has_many :products

  def self.build_from_github(auth_hash)
    user       = User.new
    user.uid   = auth_hash['uid']
    user.provider = 'github'
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']

    return user
  end

end
