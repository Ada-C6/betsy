require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "the truth" do
    assert true
  end

  test 'if an active product object is passed to active_for_button it should return "inactive"' do
    product = products(:normal_product)
    result = active_for_button(product)
    assert_equal(result, "inactive")
  end

  test 'if an inactive product object is passed to active_for_button it should return "active"' do
    product = products(:inactive_product)
    result = active_for_button(product)
    assert_equal(result, "active")
  end

  test 'if an active user object is passed to active_for_button it should return "inactive"' do
    user = users(:normal_user)
    result = active_for_button(user)
    assert_equal(result, "inactive")
  end

  test 'if an inactive user object is passed to active_for_button it should return "active"' do
    user = users(:inactive_user)
    result = active_for_button(user)
    assert_equal(result, "active")
  end


  test 'cart_count should total up the number of items in a given user\'s cart' do
    @user = users(:normal_user)
    output = cart_count
    assert_equal(output,3)
  end

  test 'cart_count should return 0 if @user is nil' do
    @user = nil
    output = cart_count
    assert_equal(output, "0")
  end

end
