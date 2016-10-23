module ApplicationHelper
  def capitalize_each_word(phrase)
    phrase.split.map(&:capitalize).join(" ")
  end

  def show_dollars(price)
    price = price / 100.0
    return number_to_currency(price)
  end

  def date_format(time)
    return time.strftime("%B %-d, %Y at %l:%M:%S %p")
  end
end
