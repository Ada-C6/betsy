class User < ActiveRecord::Base
  validates :email, :uid, :provider, presence: true
  validates_uniqueness_of :email

  has_many :orders
  has_many :reviews
  has_many :addresses

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = 'github'

    name = User.split_name(auth_hash['info']['name'])
    user.first_name = name.first
    user.last_name  = name.last

    user.email = auth_hash['info']['email']

    user.admin = false
    user.active = true

    return user
  end

  def self.split_name(name)
    unless name == nil
      array = name.split(' ')
      last_name = array.pop
      array.length == 0 ? first_name = "there" : first_name = array.join(' ')
      return first_name, last_name
    else
      return "there", "last name"
    end
  end

  def toggle_active
    # toggles active between true and false
    self.active = !self.active
  end

end
