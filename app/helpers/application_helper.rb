module ApplicationHelper

  def money_format(cents)
    sprintf("$%0.02f", cents/100.to_f)
  end
end
