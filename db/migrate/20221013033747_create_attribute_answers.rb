# frozen_string_literal: true

class CreateAttributeAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :attribute_answers do |t|
      t.belongs_to :employee_attribute, null: false, foreign_key: true
      t.belongs_to :employee, null: false, foreign_key: true
      t.string :answer, null: false
      t.index %i[employee_id employee_attribute_id], unique: true,
        name: "index_attribute_answers_on_employee_and_attribute"
      t.timestamps
    end
  end
end
