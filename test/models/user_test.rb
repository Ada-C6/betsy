require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "should not save user without all fields present (name, email uid, provider)" do
	  user = User.new
	  assert_not user.save
	  user.name = "Me"
	  assert_not user.save
	  user.email= "me@there.com"
	  assert_not user.save
	  user.uid="12369"
	  assert_not user.save
	  user.provider="github"
	  assert user.save 
	end
 
end
