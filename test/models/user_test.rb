require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "should save a user with valid fields" do
	  user = User.new
	  user.name = "Me"
	  user.email= "me@there.com"
	  user.uid="12369"
	  user.provider="github"
	  assert user.save 
	end

	test "should not save a user missing a name" do
	  user = User.new
	  user.name = nil #explicitly doing this just to highlight the fact that it's nil
	  user.email= "me@there.com"
	  user.uid="12369"
	  user.provider="github"
	  assert_not user.save 

	  user.name="a name"
	  assert user.save
	end
 
 	test "should not save a user missing an email" do
	  user = User.new
	  user.name = "Me" 
	  user.email= nil #explicitly doing this just to highlight the fact that it's nil
	  user.uid="12369"
	  user.provider="github"
	  assert_not user.save 

	  user.email="me@there.com"
	  assert user.save
	end

	test "should not save a user missing a uid" do
	  user = User.new
	  user.name = "Me" 
	  user.email= "me@there.com"
	  user.uid= nil #explicitly doing this just to highlight the fact that it's nil
	  user.provider="github"
	  assert_not user.save 

	  user.uid="12345"
	  assert user.save
	end

	test "should not save a user missing a provider" do
	  user = User.new
	  user.name = "Me" 
	  user.email= "me@there.com"
	  user.uid= "12369" 
	  user.provider= nil #explicitly doing this just to highlight the fact that it's nil
	  assert_not user.save 

	  user.provider="github"
	  assert user.save
	end

	#if time check relationships and model method
end
