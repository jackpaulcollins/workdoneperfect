# frozen_string_literal: true

require 'test_helper'

module Jumpstart
  class StaticTest < ActionDispatch::IntegrationTest
    test 'homepage' do
      get root_path
      assert_response :success
    end

    test 'dashboard' do
      sign_in users(:one)
      get root_path
      assert_select 'h1', I18n.t('dashboard.show.title')
    end
  end
end
