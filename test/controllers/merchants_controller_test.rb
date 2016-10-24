require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase
  test "show the individual merchant page" do
    merchant_id = merchants(:hilarious).id

    get :show, {id: merchant_id}
    assert_response :success
    assert_template :show

    merchant = assigns(:merchant)
    assert_not_nil merchant
    assert_equal merchant.id, merchant_id
  end

  test "show a merchant that doesn't exist" do
    merchant_id = 334456777592
    assert_raises ActiveRecord::RecordNotFound do
      Merchant.find(merchant_id)
    end

    get :show, {id: merchant_id}
    assert_response :not_found
  end
end
