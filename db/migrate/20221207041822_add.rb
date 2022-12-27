# frozen_string_literal: true

class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :job_templates, :required_resources, :string, array: true, default: []
  end
end
