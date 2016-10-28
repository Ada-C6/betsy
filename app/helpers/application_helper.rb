module ApplicationHelper
  def merchant_only_button(wheretogo, button_words, button_power, path_parameter="")
    if session[:merchant_id]
      link_to send(wheretogo, path_parameter), method: button_power do
        "<div class=\"button\"><h4>#{button_words}</h4></div>".html_safe
      end
    end
  end
  
  # solution from http://stackoverflow.com/questions/7461290/convert-cents-into-dollar-string-in-ruby-without-use-of-bigdecimal
  def add_decimal(cents)
    pfx = [ '0.00', '0.0', '0.' ]
    if(pfx[cents.to_s.length])
      cents = pfx[cents.to_s.length] + cents.to_s
    else
      cents = cents.to_s.dup
      cents[-2, 0] = '.'
    end
    return cents
  end

  def link_button(wheretogo, button_words, button_power, path_parameter="")
    link_to send(wheretogo, path_parameter), method: button_power do
      "<div class=\"button\"><h4>#{button_words}<h4></div>".html_safe
    end
  end
end
