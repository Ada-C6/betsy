require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase

  test "should get index only for logged in merchants" do
    get :index
    assert_response :redirect
    assert_equal flash[:notice], "You must be logged in to access merchant section"
  end

  test "should update db with merchant info from form" do
    session[:user_id] = merchants(:merchant1).id

    patch :update, id: merchants(:merchant1), merchant: {:displayname => 'Amazing Merchant', :location => "Rainbow Islands", :phone => "777-777-7789", :photo => "image.jpg", :email => "merch1"}
    merchant = Merchant.find_by(displayname: 'Amazing Merchant')
     #{Merchant.find(merchants(:merchant1).id).displayname}"
    assert merchant.displayname == "Amazing Merchant"
    assert merchant.location == "Rainbow Islands"
    assert merchant.phone == "777-777-7789"
    assert merchant.photo == "image.jpg"
    assert merchant.email == "merch1"
  end

  test "update operations for users not logged in as merchants will redirect" do
    put :update, :id => merchants(:merchant1), :merchant => {:displayname => "New Name"}
    assert_response :redirect
    assert_redirected_to homepages_index_path
  end


end
