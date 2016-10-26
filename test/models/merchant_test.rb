require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "merchants with minimal information must be valid" do
    assert merchants(:merchant1).valid?
  end
end
