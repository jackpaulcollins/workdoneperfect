# frozen_string_literal: true

class MakeEmployeeNameNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column :employees, :first_name, :string, null: false
  end
end
