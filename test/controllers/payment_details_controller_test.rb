require 'test_helper'

class PaymentDetailsControllerTest < ActionController::TestCase
  test "should show payment detail" do
    get :show, {id: payment_details(:payment_card).id}
    assert_response :success
  end

  test "should get new" do
    get :new, order_id: payment_details(:payment_card).id

    assert_response :success
  end

  # test "should create payment detail" do
  #   order_id = payment_details(:controller_test_card).order_id
  #   # assert_difference('PaymentDetail.count', 1) do
  #     post :create, { payment_detail:
  #       {
  #         order_id: order_id,
  #         buyer_name: "Testing Person",
  #         email: "mama@mama.com",
  #         street: "Hauptstrasse",
  #         city: "Hamburg",
  #         state: "Germany",
  #         zip: 54321,
  #         cc_four_digits: 5105,
  #         cc_expiration_date: "2017-10-24 13:53:49 -0700",
  #         time_placed: "2016-10-24 12:53:49 -0700",
  #         CVV: 111
  #       }, order_id: order_id
  #     }
  #   # end
  #
  #   assert_response :redirect
  #   assert_redirected_to payment_details_path
  # end
end
