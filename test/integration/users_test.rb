# frozen_string_literal: true

require "test_helper"

module Jumpstart
  class UsersTest < ActionDispatch::IntegrationTest
    test "user can delete their account" do
      sign_in users(:one)
      assert_difference "User.count", -1 do
        delete "/users"
      end
      assert_redirected_to root_path
    end

    test "invalid time zones are handled safely" do
      user = users(:one)
      user.update! time_zone: "invalid"

      sign_in user
      get root_path
      assert_response :success
    end
  end
end
