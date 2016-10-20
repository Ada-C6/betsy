class User < ActiveRecord::Base
  has_many :reviews
  has_many :products


  validates :email, :id, :provider, presence: true

  def self.build_from_github(auth_hash)
    user       = User.new
    user.id   = auth_hash[:id]
    user.provider = 'github'
    user.first_name  = auth_hash['info']['first_name']
    user.last_name  = auth_hash['info']['last_name']
    user.email = auth_hash['info']['email']

    return user
  end
end
