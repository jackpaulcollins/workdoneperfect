# frozen_string_literal: true

class NullableInvitedByAccountInvitations < ActiveRecord::Migration[6.0]
  def change
    change_column_null :account_invitations, :invited_by_id, true
  end
end
