# frozen_string_literal: true

class ChangeResourceName < ActiveRecord::Migration[7.0]
  def change
    rename_table :resources, :company_resources
    remove_column :company_resources, :count
  end
end
