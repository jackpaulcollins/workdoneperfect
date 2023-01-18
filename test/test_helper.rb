# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/mock"

# Uncomment to view full stack trace in tests
# Rails.backtrace_cleaner.remove_silencers!

require "sidekiq/testing" if defined?(Sidekiq)

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def switch_account(account)
      patch "/accounts/#{account.id}/switch"
    end

    def json_response
      ::JSON.parse(response.body)
    end

    def assert_permit(user, record, action)
      msg = "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted"
      assert permit(user, record, action), msg
    end
    
    def refute_permit(user, record, action)
      msg = "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted"
      refute permit(user, record, action), msg
    end
    
    def permit(user, record, action)
      cls = self.class.to_s.gsub(/Test/, '')
      cls.constantize.new(user, record).public_send("#{action.to_s}?")
    end
  end
end

module ActionDispatch
  class IntegrationTest
    include Devise::Test::IntegrationHelpers
  end
end
