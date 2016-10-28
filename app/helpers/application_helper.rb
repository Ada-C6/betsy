module ApplicationHelper
  def currency(amount)
    sprintf("$%0.02f", amount/100.to_f)
  end

  def pretty_date(datetime)
    datetime.strftime("%I:%M %p, %A, %B %d, %Y (%Z)")
  end

  def copyright_notice_year_range(start_year)
  # In case the input was not a number (nil.to_i will return a 0)
  start_year = start_year.to_i

  current_year = Time.new.year

    if current_year > start_year && start_year > 2000
      "#{start_year} - #{current_year}"
    elsif start_year > 2000
      "#{start_year}"
    else
      "#{current_year}"
    end
  end

  def user_name
    begin
      unless session[:user_id].nil?
        user = User.find(session[:user_id])
        if user.user_name
          return user.user_name
      end
        return "Guest"
      end
    rescue ActiveRecord::RecordNotFound
      return "ERROR: user not in database"
    end
  end

  def login_status
    if session[:user_id].nil?
      "Viewing as Guest"
    else
      "Logged in as #{user_name}"
    end
  end
end
