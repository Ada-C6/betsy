module ApplicationHelper
  def greeting
    if current_merchant.nil?
      "Welcome Guest"
    else
      "Welcome #{current_merchant.name}"
    end
  end
end
