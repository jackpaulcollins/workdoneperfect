# frozen_string_literal: true

class AddColumnsToEmployeeTemplate < ActiveRecord::Migration[7.0]
  def change
    add_column :employee_attributes, :data_type, :integer
    add_column :employee_attributes, :required, :boolean, default: false
  end
end
