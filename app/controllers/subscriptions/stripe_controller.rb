# frozen_string_literal: true

module Subscriptions
  class StripeController < ApplicationController
    # Handles Stripe PaymentElement callback

    before_action :authenticate_user!
    before_action :require_current_account_admin
    before_action :set_subscription, only: [:show]

    def show
      @subscription = Pay::Stripe::Subscription.sync(@subscription.processor_id)

      if @subscription.active?
        current_account.set_payment_processor :stripe
        redirect_to root_path, notice: t("subscriptions.created")
      else
        redirect_to root_path, alert: t("something_went_wrong")
      end
    end

    private

    def set_subscription
      @subscription = current_account.subscriptions.find_by_prefix_id!(params[:subscription_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to subscriptions_path
    end
  end
end
