module ApplicationHelper


  def star_string(rating)
    printed_stars = ""
    rating.times {|x| printed_stars << "★"}
    (5-rating).times {|x| printed_stars << "☆"}
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
