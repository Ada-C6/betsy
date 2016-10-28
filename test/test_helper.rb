ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'simplecov'
SimpleCov.start


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  Minitest::Reporters.use!

  def setup
  # Turn on test mode - auth requests will be short-circuited
  # OmniAuth.config.test_mode = true
  # What data should we get back from auth requests?

  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
    provider: 'google', uid: '88888', info: { email: "a@b.com", name: "Ada" }
    })
  end
end
