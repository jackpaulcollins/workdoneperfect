# frozen_string_literal: true

module Users
  class AgreementsController < ApplicationController
    skip_before_action :require_accepted_latest_agreements!
    before_action :authenticate_user!
    before_action :set_agreement

    layout "minimal"

    def show
      respond_to do |format|
        format.html
        format.json { render json: {error: t(".description", agreement: @agreement.title)} }
      end
    end

    def update
      current_user.update!(@agreement.column => Time.current)
      redirect_to after_accepted_path
    end

    def destroy
      Devise.sign_out_all_scopes ? sign_out : sign_out(current_user)
      redirect_to after_sign_out_path_for(:user), alert: t(".declined", agreement: @agreement.title)
    end

    private

    def set_agreement
      @agreement = Rails.application.config.agreements.find { _1.id.to_s == params[:id] }

      return unless @agreement.accepted_by?(current_user)

      redirect_to after_accepted_path
    end

    def after_accepted_path
      stored_location_for(:user) || root_path
    end
  end
end
