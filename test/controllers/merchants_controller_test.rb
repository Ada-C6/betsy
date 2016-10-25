require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase

test "should get index" do
  get :index
  assert_response :success
end

test "should get show" do
  get :show, id: merchants(:one).id
  assert_response :success
end

# positive/negative create tests

end
