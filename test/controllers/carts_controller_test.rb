require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
def cart_create
  if !session[:cart].nil?
    @cart = session[:cart]
  else
    session[:cart] = []
    @cart = session[:cart]
  end
end
test "should get the index page" do
  get :index
  assert_template :index
  assert_response :success
end

 test "Can create a cart" do
   cart_create
   assert_difference('@cart.count', 1) do
   end
 end


end
