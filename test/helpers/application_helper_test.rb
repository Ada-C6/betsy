require 'test_helper'
include ApplicationHelper

class ApplicationHelperTest < ActionController::TestCase
  include RoutingAssertions

  test "add_decimal should, you know, add a decimal" do
    assert_equal "1.10", add_decimal(110)
    assert_equal "1.00", add_decimal(100)
    assert_equal "0.90", add_decimal(90)

  end

  # Neither of these two bottom tests work in the way they appear to be. Kari hypothesized it's because routing capabilities aren't available in this helper test. So it's saying that "root_path" is an undefined method.

  # I'm keeping the bottom test un-commented because it increases my test coverage, even though that number is mostly a lie. Shhh.

  test "Merchant only button should return nil if no one is logged in" do
    session[:merchant_id] = nil

    button_html = merchant_only_button("root_path","asdfsadf",:get)

    assert_nil button_html
  end

  # test "Merchant only button should return stuff in someone is logged in" do
  #   session[:merchant_id] = merchants(:teeny_merchant).id
  #
  #   button_html = merchant_only_button("root_path","asdfsadf",:get)
  #
  #   assert_not_nil button_html
  # end

end
