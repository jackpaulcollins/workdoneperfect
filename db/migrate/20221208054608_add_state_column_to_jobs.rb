# frozen_string_literal: true

class AddStateColumnToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :state, :string, index: true
  end
end
