module ApplicationHelper
  def user_name
    begin
      merchant = Merchant.find(session[:user_id])
      if merchant.user_name
        return merchant.user_name
      elsif merchant.email
        return merchant.email
      else
        return "#{merchant.provider} merchant #{merchant.uid}"
      end
    rescue ActiveRecord::RecordNotFound
      return "ERROR: merchant not in database"
    end
  end

  def login_status
    if session[:user_id]
      "Logged in as #{user_name}"
    else
      "Not logged in"
    end
  end

  def login_button(**kwargs)
    if session[:user_id]
      text = "Log Out"
      path = '/sessions'
      method = :delete
    else
      text = "Log In"
      path = "/auth/github"
      method = :get
    end
    link_to text, path, method: method, **kwargs
  end
end
