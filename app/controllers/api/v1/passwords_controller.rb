# frozen_string_literal: true

module Api
  module V1
    class PasswordsController < Api::BaseController
      before_action :configure_permitted_parameters, only: [:create]

      def update
        if current_user.update_with_password(password_params)
          current_user.remember_me = true
          bypass_sign_in current_user
          render json: { success: true }
        else
          render json: {
            error: current_user.errors.full_messages.to_sentence
          }, status: :unprocessable_entity
        end
      end

      private

      def password_params
        params.require(:user).permit(:current_password, :password, :password_confirmation)
      end
    end
  end
end
