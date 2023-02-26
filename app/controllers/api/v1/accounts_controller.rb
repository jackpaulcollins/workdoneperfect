# frozen_string_literal: true

module Api
  module V1
    class AccountsController < Api::BaseController
      def index
        @accounts = current_user.accounts
        render 'accounts/index'
      end
    end
  end
end
