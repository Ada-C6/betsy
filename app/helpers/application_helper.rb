module ApplicationHelper


  def star_string(rating)
    printed_stars = ""
    rating.times {|x| printed_stars << "⭐️"}
    printed_stars.html_safe
  end
  
  def greeting
    if current_merchant.nil?
      "Welcome Guest"
    else
      "Welcome #{current_merchant.name}"
    end
  end
end

#
# def readable_date(date)
#   ("<span class='date'>" + date.strftime("%A, %b %d") + "</span>").html_safe
# end
#
# def random_image(width, height)
#   number = rand(3)
#   url = ""
#   case number
#   when 0
#     url = "http://www.fillmurray.com/"
#   when 1
#     url = "http://www.placecage.com/"
#   when 2
#     url = "http://placekitten.com/"
#   end
#   ["<img src='", url, width,"/" ,height, "' alt='random image'>"].join.html_safe
# end
