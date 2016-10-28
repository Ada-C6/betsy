require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "the truth" do
    assert true
  end

  ######## test user validations ##############
  test 'users must have email' do
    assert(users(:normal_user).valid?)
    assert_not(users(:user_without_email).valid?)
  end

  test 'if an email is added to a user w/o email, it should become valid' do
    user = users(:user_without_email)
    assert_not(user.valid?)

    user.email = "cat@caterpillar.com"
    assert(user.valid?)
  end

  test 'new users created without emails are not valid' do
    user = User.new(first_name: "lauren", last_name: "cat", birthdate: "2011-01-03", phone: 23954343, admin: false, active: true, uid: 23953540, provider: 'github')
    assert_not(user.valid?)
  end

  test 'user emails should be unique' do
    user = users(:user_without_email)
    user.email = "edith@edith.com" # the email address of :normal_user
    assert_not(user.valid?)
  end
  ########### test user relationships with orders, reviews, addresses #############

  test 'users without non essential info are still valid' do
    assert(users(:user_without_extras).valid?)
  end

  test 'users can have orders' do
    assert_not_empty(users(:normal_user).orders)

    user = users(:user_without_extras)
    order = Order.new(user_id: users(:user_without_extras).id, shipping_cost: 12004, order_status: "all right, not great")

    order.save
    assert_not_empty(user.orders)
  end

  test 'users can have reviews' do
    assert_not_empty(users(:normal_user).reviews)

    user = users(:user_without_extras)
    review = Review.new(user_id: users(:user_without_extras).id, subject: "sup this is a review", rating: 5, product_id: 12)

    review.save
    assert_not_empty(user.reviews)
  end

  test 'users can have addresses' do
    assert_not_empty(users(:normal_user).addresses)

    user = users(:user_without_extras)
    address = Address.new(user_id: users(:user_without_extras).id, kind: "home", last_name: "big papi", street1: "943 northern way", city: "Moscow", state: "state", country: "canada")

    address.save
    assert_not_empty(user.addresses)
  end

########## test build_from_github method ##############

  def setup
    @auth_hash = {uid: 1294953,
                'info' => {'name' => 'beyonce knowles',
                          'email' => 'bey@beyoncy.com'}}
  end

  test 'given a good auth hash from github, build_from_github will create a valid user' do
    user = User.build_from_github(@auth_hash)
    assert(user.valid?)
  end

  test 'when a new user is created it increases the count of users by 1' do
    assert_difference 'User.count', 1 do
      user = User.build_from_github(@auth_hash)
      user.save
    end
  end

  test 'newly created github users should not be admins' do
    user = User.build_from_github(@auth_hash)
    assert_not(user.admin)
  end

  test 'newly created github users should be active' do
    user = User.build_from_github(@auth_hash)
    assert(user.active)
  end

  test 'users created via this method should have a provider of "github"' do
    user = User.build_from_github(@auth_hash)
    assert_equal(user.provider, 'github')
  end

############ test toggle_active method ##################

  test 'when passed an active user, the toggle_active method should switch them to inactive' do
    user = users(:normal_user)
    user.toggle_active
    assert_not(user.active)
  end

  test 'when passed an inactive user, the toggle_active method should switch them to active' do
    user = users(:inactive_user)
    user.toggle_active
    assert(user.active)
  end


############ test split_name method ##################
  test 'when given a name, split_name should split it into first and last' do
    name = "Beyonce Knowles"
    a, b = User.split_name(name)
    assert_equal(a, "Beyonce")
    assert_equal(b, "Knowles")
  end

  test 'when given a compound name, only the last of all the names should be the last name' do
    name = "Becky With The Good Hair"
    a, b = User.split_name(name)
    assert_equal(a, "Becky With The Good")
    assert_equal(b, "Hair")
  end

  test 'when given nil, split_name should return "there" for the first name and a last name "last name"' do
    name = nil
    a,b = User.split_name(name)
    assert_not_nil(a)
    assert_equal(a, "there")
    assert_not_nil(b)
    assert_equal(b, "last name")
  end

  test 'when given a single name, split_name should return "there" for a first name and the single name for the last name' do
    name = "cat"
    a,b = User.split_name(name)
    assert_equal(a,"there")
    assert_equal(b, "cat")
  end
end
