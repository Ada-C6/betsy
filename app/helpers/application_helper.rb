module ApplicationHelper
  def user_name
    begin
      user = Merchant.find(session[:merchant_id])
      if user.user_name
        return user.user_name
      elsif user.email
        return user.email
      else
        return "#{user.provider} user #{user.uid}"
      end
    rescue ActiveRecord::RecordNotFound
      return "ERROR: user not in database"
    end
  end

  def login_status
    if session[:merchant_id].nil?
      sign_up_button
    else
    # if a Merchant is logged in they can see their dashboard
      link_to "#{user_name.upcase}'S Dashboard", sessions_merchant_login_path, method: :get
    end
  end

  def login_button(**kwargs)
    if session[:merchant_id].nil?
      text = "Log In"
      path = "/auth/github"
      method = :get
    else
      text = "Log Out"
      path = sessions_path
      method = :delete
    end
    link_to text, path, method: method, **kwargs
  end

  def sign_up_button(**kwargs)
    if session[:merchant_id].nil?
      text = "Sign Up with Github"
      path = "https://github.com/join?source=header-home"
      method = :get
    end
    link_to text, path, method: method, **kwargs
  end

  def cart_button(**kwargs)
    order = session[:order_id]
    if !order.nil?
      text = "Cart"
      path = order_order_items_path(order)
      method = :get
    link_to text, path, method: method, **kwargs
    end
  end

  def product_image(product, pic_size, **kwargs)
    if product.image.nil?
      path = ["robot.png", "baby_robot .jpg", "ran_rob.png", "ran_robot_2.png", "ran-robot.png"].sample
      dimensions = pic_size
      text = "Robits"
    else
      path = (product.image_stored? ? product.image.thumb(pic_size).url : "")
      dimensions = pic_size
      text = "Buy Me"
    end
    image_tag path, size: dimensions, alt: text
  end

  def render_date(date)
    ("<span class='date'>" + date.strftime("%A, %b %d %Y") +  "</span>").html_safe
  end

end
