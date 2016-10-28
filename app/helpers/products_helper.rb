module ProductsHelper
  def stars(rating)
    int_rating = rating.to_i
    return (("&#x2605;" * int_rating) + ("&#x2606;" * (5 - int_rating) )).html_safe
    # NOTE: &#x2605; is black star; &#x2606; is white star
  end
end
