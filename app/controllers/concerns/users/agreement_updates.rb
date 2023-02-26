# frozen_string_literal: true

module Users
  module AgreementUpdates
    # Enforces users to accept the latest terms of service & privacy policy changes
    extend ActiveSupport::Concern

    included do
      before_action :require_accepted_latest_agreements!, if: lambda {
                                                                request.get? && user_signed_in? && !devise_controller?
                                                              }
    end

    def require_accepted_latest_agreements!
      Rails.application.config.agreements.each do |agreement|
        next unless agreement.not_accepted_by?(current_user)

        respond_to do |format|
          format.html do
            store_location_for(:user, request.fullpath) unless request.fullpath.start_with?("/agreements/")
            redirect_to agreement_path(agreement)
          end
          format.json { render json: {error: t("users.agreements.show.description", agreement: agreement.title)} }
        end

        break
      end
    end
  end
end
