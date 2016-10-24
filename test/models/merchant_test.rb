require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "Create a valid merchant" do
    assert merchants(:snoopy).valid?
  end

  test "Cannot create a merchant with missing information" do
    merchant = Merchant.new
    assert_not merchant.valid?
    assert_includes merchant.errors, :username
    assert_includes merchant.errors, :email
  end

  test "Should not create a merchant with the same username or email as another" do
    Merchant.create!(username: "foo", email: "foo@hotmail.com")
    m2 = Merchant.new(username: "foo", email: "other@hotmail.com")
    m3 = Merchant.new(username: "other", email: "foo@hotmail.com")
    assert_not m2.valid?
    assert_not m3.valid?
  end

  # def login_a_merchant
  #   request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  #   get :create,  {provider: "github"}
  # end
  #
  # test "Can Create a merchant" do
  #   assert_difference('Merchant.count', 1) do
  #     login_a_merchant
  #     assert_response :redirect
  #     assert_redirected_to root_path
  #   end
  # end
  #
  # test "If a merchant logs in twice it doesn't create a 2nd merchant" do
  #   assert_difference('Merchant.count', 1) do
  #     login_a_merchant
  #   end
  #   assert_no_difference('Merchant.count') do
  #     login_a_merchant
  #     assert_response :redirect
  #     assert_redirected_to root_path
  #   end
  # end

end
