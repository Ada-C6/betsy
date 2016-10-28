class Merchant < ActiveRecord::Base
  has_many :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :uid, :provider, presence: true

  def add_decimal(cents)
    pfx = [ '0.00', '0.0', '0.' ]
    if(pfx[cents.to_s.length])
      cents = pfx[cents.to_s.length] + cents.to_s
    else
      cents = cents.to_s.dup
      cents[-2, 0] = '.'
    end
    return cents
  end


  def self.build_from_github(auth_hash)
    merchant       = Merchant.new
    merchant.uid   = auth_hash[:uid]
    merchant.provider = 'github'
    if auth_hash['info']['name'] != nil
      merchant.username  = auth_hash['info']['name']
    else
      merchant.username  = auth_hash['info']['nickname']
    end
    merchant.email = auth_hash['info']['email']

    return merchant
  end

  def find_all_order_items_revenue
    if products.nil?
      return nil
    end

    sum = 0

    products.each do |product|
      order_items = OrderItem.where(product_id: product.id)
      order_items.each do |item|
        if Order.find(item.order_id).status == 'pending'
          sum += item.quantity * product.price

        elsif Order.find(item.order_id).status == 'paid'
          sum += item.quantity * product.price

        elsif Order.find(item.order_id).status == 'complete'
          sum += item.quantity * product.price

        elsif Order.find(item.order_id).status == 'shipped'
          sum += item.quantity * product.price
        end
      end
    end

    if !sum.nil?
      sum = "$" + add_decimal(sum)
    end
    return sum
  end

  def find_all_order_items_revenue_by_status
    if products.nil?
      return nil, nil, nil
    end

    pending_subtotals = []
    paid_subtotals = []
    complete_subtotals = []
    shipped_subtotals = []

    products.each do |product|
      order_items = OrderItem.where(product_id: product.id)
      order_items.each do |item|
        if Order.find(item.order_id).status == 'pending'
          pending_subtotals.push(item.quantity * product.price)

        elsif Order.find(item.order_id).status == 'paid'
          paid_subtotals.push(item.quantity * product.price)

        elsif Order.find(item.order_id).status == 'complete'
          complete_subtotals.push(item.quantity * product.price)

        elsif Order.find(item.order_id).status == 'shipped'
          shipped_subtotals.push(item.quantity * product.price)
        end
      end
    end

    pending_revenue = pending_subtotals.reduce(:+)
    paid_revenue = paid_subtotals.reduce(:+)
    complete_revenue = complete_subtotals.reduce(:+)
    shipped_revenue = shipped_subtotals.reduce(:+)

    if !pending_revenue.nil?
      pending_revenue = "$" + add_decimal(pending_revenue)
    end

    if !paid_revenue.nil?
      paid_revenue = "$" + add_decimal(paid_revenue)
    end

    if !complete_revenue.nil?
      complete_revenue = "$" + add_decimal(complete_revenue)
    end

    if !shipped_revenue.nil?
      complete_revenue = "$" + add_decimal(shipped_revenue)
    end

    return pending_revenue, paid_revenue, complete_revenue, shipped_revenue
  end

  def find_total_number_of_orders_by_status
    if products.nil?
      return nil, nil, nil, nil, nil
    end

    pending = 0
    paid = 0
    complete = 0
    cancelled = 0
    shipped = 0

    products.each do |product|
      order_items = OrderItem.where(product_id: product.id)
      order_items.each do |item|
        if Order.find(item.order_id).status == 'pending'
          pending += 1

        elsif Order.find(item.order_id).status == 'paid'
          paid += 1

        elsif Order.find(item.order_id).status == 'complete'
          complete += 1

        elsif Order.find(item.order_id).status == 'cancelled'
          cancelled += 1

        elsif Order.find(item.order_id).status == 'shipped'
          shipped += 1
        end
      end
    end
    return pending, paid, complete, cancelled, shipped
  end

  def find_orders
    if products.nil?
      return nil
    end

    orders = []

    products.each do |product|
      order_items = OrderItem.where(product_id: product.id)
      order_items.each do |item|
        orders.push( Order.find(item.order_id))
      end
    end
    return orders
  end

  def find_order_items_from_orders
    if products.nil?
      return nil
    end

    order_details = []

    products.each do |product|
      order_items = OrderItem.where(product_id: product.id)
      order_items.each do |item|
        order_details.push([Order.find(item.order_id).id, product.name, product.id, item.quantity, product.price * item.quantity])
      end
    end
    return order_details
  end
end
