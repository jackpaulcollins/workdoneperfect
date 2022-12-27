# frozen_string_literal: true

class AddInteractedAtToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :interacted_at, :datetime
  end
end
