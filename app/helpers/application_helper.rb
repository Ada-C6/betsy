module ApplicationHelper
  def capitalize_each_word(phrase)
    phrase.split.map(&:capitalize).join(" ")
  end

  def show_dollars(price)
    price = price / 100.0
    number_to_currency(price)
  end
end
