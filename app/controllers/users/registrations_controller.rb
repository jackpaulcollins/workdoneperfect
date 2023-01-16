# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    invisible_captcha only: :create

    protected

    def build_resource(hash = {})
      self.resource = resource_class.new_with_session(hash, session)

      # Jumpstart: Skip email confirmation on registration.
      #   Require confirmation when user changes their email only
      resource.skip_confirmation!

      # Registering to accept an invitation should display the invitation on sign up
      if params[:invite] && (invite = AccountInvitation.find_by(token: params[:invite]))
        @account_invitation = invite
        resource.skip_default_account = true

      # Build and display account fields in registration form if enabled
      elsif Jumpstart.config.register_with_account?
        account = resource.owned_accounts.first
        account ||= resource.owned_accounts.new
        account.account_users.new(user: resource, admin: true)
      end
    end

    def update_resource(resource, params)
      # Jumpstart: Allow user to edit their profile without password
      resource.update_without_password(params)
    end

    def sign_up(resource_name, resource)
      sign_in(resource_name, resource)

      # If user registered through an invitation, automatically accept it after signing in
      return unless @account_invitation
      maybe_claim_employee
      @account_invitation.accept!(current_user)

      # Clear redirect to account invitation since it's already been accepted
      stored_location_for(:user)
    end

    def maybe_claim_employee
      # Runs before the create user action
      # if the email provided by the user
      # doesn't match the email entered by the owner
      # reject the attempt
      return unless params[:invite]

      if (@employee = Employee.find_by(email: params[:user][:email]))
        @employee.claimed_by_id = current_user.id
        @employee.claim
        @employee.save
      else
        flash[:alert] = "Email address not found. Try again or contact your employer"
        redirect_to "/users/sign_up?invite=#{params[:invite]}" and return
      end
    end
  end
end
