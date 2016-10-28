require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase
  setup do
    @merchant = merchants(:teeny_merchant)
  end

  test "(show) should show the requested merchant record" do
    merchant_id = @merchant.id
    get :show, { id: merchant_id }
    assert_response :success
    assert_template :show

    merchant = assigns(:merchant)
    assert_not_nil merchant
    assert_equal @merchant.id, merchant_id
  end

  test "(show) should not show a non-existing merchant record" do
    merchant_id = 123456789
    assert_raises ActiveRecord::RecordNotFound do
      Merchant.find(merchant_id)
    end

    get :show, { id: merchant_id }
    assert_response :not_found
  end
end
