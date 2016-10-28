require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # woo hoo easy tests!
  test "the truth" do
    assert true
  end

  ####### validations ######
  test 'addresses must have kind' do
    assert_not(addresses(:address_without_kind).valid?)
  end

  test 'if a kind is added to an address it must become valid' do
    address = addresses(:address_without_kind)
    assert_not(address.valid?)

    address.kind = "cat"
    address.save

    assert(address.valid?)
  end

  test 'new addresses created without kinds are not valid' do
    address = Address.new(last_name: "cat", street1: "cat", city: "cat", state: "cat", country: "cat", user_id: 1000)
    address.save

    assert_not(address.valid?)
  end
#########
  test 'addresses must have last_name' do
    assert_not(addresses(:address_without_last_name).valid?)
  end

  test 'if a last_name is added to an address it must become valid' do
    address = addresses(:address_without_last_name)
    assert_not(address.valid?)

    address.last_name = "cat"
    address.save

    assert(address.valid?)
  end

  test 'new addresses created without last_names are not valid' do
    address = Address.new(kind: "cat", street1: "cat", city: "cat", state: "cat", country: "cat", user_id: 1000)
    address.save

    assert_not(address.valid?)
  end
#########
  test 'addresses must have street1' do
    assert_not(addresses(:address_without_street1).valid?)
  end

  test 'if a street1 is added to an address it must become valid' do
    address = addresses(:address_without_street1)
    assert_not(address.valid?)

    address.street1 = "cat and/or dog"
    address.save

    assert(address.valid?)
  end

  test 'new addresses created without street1 are not valid' do
    address = Address.new(kind: "cat", last_name: "cat", city: "cat", state: "cat", country: "cat", user_id: 1000)
    address.save

    assert_not(address.valid?)
  end

  ########

  test 'addresses must have city' do
    assert_not(addresses(:address_without_city).valid?)
  end

  test 'if a city is added to an address it must become valid' do
    address = addresses(:address_without_city)
    assert_not(address.valid?)

    address.city = "dog this time"
    address.save

    assert(address.valid?)
  end

  test 'new addresses created without city are not valid' do
    address = Address.new(kind: "cat", last_name: "cat", street1: "cat", state: "cat", country: "cat", user_id: 1000)
    address.save

    assert_not(address.valid?)
  end
  ########

  test 'addresses must have state' do
    assert_not(addresses(:address_without_state).valid?)
  end

  test 'if a state is added to an address it must become valid' do
    address = addresses(:address_without_state)
    assert_not(address.valid?)

    address.state = "solange knowles"
    address.save

    assert(address.valid?)
  end

  test 'new addresses created without state are not valid' do
    address = Address.new(kind: "cat", last_name: "cat", street1: "cat", city: "cat", country: "cat", user_id: 1000)
    address.save

    assert_not(address.valid?)
  end
  ########

  test 'addresses must have country' do
    assert_not(addresses(:address_without_country).valid?)
  end

  test 'if a country is added to an address it must become valid' do
    address = addresses(:address_without_country)
    assert_not(address.valid?)

    address.country = "mississippi"
    address.save

    assert(address.valid?)
  end

  test 'new addresses created without country are not valid' do
    address = Address.new(kind: "cat", last_name: "cat", street1: "cat", city: "cat", state: "cat", user_id: 1000)
    address.save

    assert_not(address.valid?)
  end
  ########

  test 'addresses without non-essential info are valid' do
    assert(addresses(:address_without_extras).valid?)
  end

  ######## testing relationships with user ###########

  test 'addresses must belong to a user' do
    assert(addresses(:normal_address).valid?)
    assert_not(addresses(:address_without_user).valid?)
  end

  test 'addresses should have the correct user' do
    address = addresses(:normal_address)
    user = users(:normal_user)

    assert_equal(address.user_id, user.id)
  end

end
