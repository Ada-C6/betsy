

ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
  add_filter "/config/"
  add_filter "/helpers"
end
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  Minitest::Reporters.use!
  # Add more helper methods to be used by all tests here...

  def setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({provider: 'github', uid: '99999', info: { email: "a@b.com", name: "Ada"}})
  end
end
