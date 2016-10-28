ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
require 'simplecov'
SimpleCov.start
Rails.application.eager_load!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  Minitest::Reporters.use!
  # Turn on test mode - auth requests will be short-circuited
  OmniAuth.config.test_mode = true
  # What data should we get back from auth requests?
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    provider: 'github', uid: '99999', info: { email: "a@b.com", name: "Ada" }
    })

  OmniAuth.config.mock_auth[:github2] = OmniAuth::AuthHash.new({
    provider: 'github', uid: '99999', info: { email: "a@b.com", nickname: "Ada" }
    })
  # Add more helper methods to be used by all tests here...
end
