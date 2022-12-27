# frozen_string_literal: true

class AddPreferredLanguageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :preferred_language, :string
  end
end
