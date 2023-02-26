# frozen_string_literal: true

require "test_helper"

module Jumpstart
  class HerokuTest < ActiveSupport::TestCase
    def test_valid_app_json_syntax
      JSON.parse(File.read("app.json"))
    end
  end
end
