# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :employee_template, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.datetime :start_date
      t.datetime :final_date

      t.timestamps
    end
  end
end
