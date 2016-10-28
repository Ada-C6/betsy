class User < ActiveRecord::Base
  has_many :products
  has_many :order_items, through: :products

  validates :user_name, :email, :uid, :provider, presence: true
  validates :user_name, :email, uniqueness: true


  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def self.build_from_github(auth_hash)
    #encapsulating the functionality of building the user from github from model instead of controller
    user       = User.new #create a new user
    user.uid   = auth_hash[:uid] #assign attributes
    user.provider = 'github'
    user.user_name  = auth_hash['info']['nickname']
    user.email = auth_hash['info']['email']
    # could user.save here then return true or false and pivot on that in the controller
    #@TODO need to add something here to give a user a user_name when nil from Github, something like:
    # if user.user_name.nil?
    #   user.user_name = "Github Seller #{user.uid}"
    # end ?? -dkl
    return user
  end

  def orders
    orders = self.order_items.map do |item|
      item.order
    end
    return orders.uniq
  end

  def orders_by_status(status)
    results = []
    self.orders.each do |order|
      results << order if order.status == status
    end
    return results
  end

  def revenues
    revs = self.order_items.map do |item|
      item.subtotal
    end
    return revs.reduce(:+)
  end

  def revenues_by_status(status)
    results = []
    self.orders_by_status(status).each do |order|
      order.order_items.each do |item|
        results << item.subtotal if self.products.include?(item.product)
      end
    end
    return results.reduce(:+)
  end
end
