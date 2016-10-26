ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  Minitest::Reporters.use!

  # Add more helper methods to be used by all tests here...
  def setup
    # Once test mode is enabled, all requests to OmniAuth will be short circuited
    # to use the mock authentication hash.
    OmniAuth.config.test_mode = true

    # Settng the mock_auth configuration for Github
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github', uid: '123545', info: { email: "a@b.com", nickname: "Ada" }
    })
  end
end
