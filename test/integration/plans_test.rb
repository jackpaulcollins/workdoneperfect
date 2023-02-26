# frozen_string_literal: true

require "test_helper"

module Jumpstart
  class PlansTest < ActionDispatch::IntegrationTest
    fixtures :plans

    setup do
      # Two expects handle multiple calls, if Braintree & PayPal are both enabled for example
      mock_client_token = Minitest::Mock.new
      mock_client_token.expect :generate, "mock_client_token"
      mock_client_token.expect :generate, "mock_client_token"

      mock_gateway = Minitest::Mock.new
      mock_gateway.expect :client_token, mock_client_token
      mock_gateway.expect :client_token, mock_client_token
      Pay.braintree_gateway = mock_gateway
    end

    test "redirects when there are no plans" do
      Plan.delete_all
      get "/pricing"
      assert_redirected_to root_url
    end

    test "view pricing page when there are plans" do
      get "/pricing"

      Plan.visible.find_each do |plan|
        assert response.body.include?(plan.name)
      end
    end

    if Jumpstart.config.payments_enabled?
      test "redirects to billing address form when attempting checkout with no billing address set" do
        Jumpstart.config.stub(:collect_billing_address?, true) do
          sign_in users(:user_without_billing_address)
          plan = plans(:personal)

          get new_subscription_path(plan: plan.id)

          assert_redirected_to subscriptions_billing_address_path(plan: plan.id)
        end
      end

      test "can view subscribe page for a plan" do
        sign_in users(:one)
        plan = plans(:personal)

        get new_subscription_path(plan: plan.id)

        assert response.body.include?(plan.name)
        plan.features.each do |feature|
          assert response.body.include?(feature)
        end
      end

      test "can view subscribe page for a account plan" do
        account = accounts(:company)
        user = account.owner
        plan = plans(:personal)

        sign_in user
        switch_account(account)
        get new_subscription_path(plan: plan.id)

        assert response.body.include?(account.name)
        assert response.body.include?(plan.name)
        plan.features.each do |feature|
          assert response.body.include?(feature)
        end
      end
    end
  end
end
