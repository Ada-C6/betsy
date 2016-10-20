ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

#add colors and make it more readable
require 'minitest/reporters'
require "awesome_print"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
#tell it to use the thing to make it more readable
  MiniTest::Reporters.use!

  # Add more helper methods to be used by all tests here...

#omniauth setup method
	def setup
	  # Once you have enabled test mode, all requests
	  # to OmniAuth will be short circuited to use the mock authentication hash.
	  # A request to /auth/provider will redirect immediately to /auth/provider/callback.
	  OmniAuth.config.test_mode = true

	  # The mock_auth configuration allows you to set per-provider (or default) authentication
	  # hashes to return during testing.
	  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
	    provider: 'github', id: '123545', info: { email: "a@b.com", name: "Ada" }
	  })
	end
end
