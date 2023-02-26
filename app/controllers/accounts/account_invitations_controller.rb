# frozen_string_literal: true

module Accounts
  class AccountInvitationsController < Accounts::BaseController
    before_action :set_account
    before_action :require_account_admin
    before_action :set_account_invitation, only: %i[edit update destroy]
    before_action :set_employee, only: %i[create]

    def new
      @account_invitation = AccountInvitation.new
    end

    def create
      @account_invitation = AccountInvitation.new(invitation_params.except(:employee_id))
      if @account_invitation.save_and_send_invite

        if @employee
          @employee.mark_pending_invite!
          flash[:notice] = "Employee was successfully invited"
          redirect_to @employee
        else
          redirect_to @account
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @account_invitation.update(invitation_params)
        redirect_to @account, notice: t(".updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @account_invitation.destroy
      redirect_to @account, status: :see_other, notice: t(".destroyed")
    end

    private

    def set_account
      @account = current_user.accounts.find(params[:account_id])
    end

    def set_account_invitation
      @account_invitation = @account.account_invitations.find_by!(token: params[:id])
    end

    def set_employee
      @employee = Employee.find_by_id(invitation_params[:employee_id])
    end

    def invitation_params
      params
        .require(:account_invitation)
        .permit(:name, :email, AccountUser::ROLES, :employee_id)
        .merge(account: @account, invited_by: current_user)
    end
  end
end
