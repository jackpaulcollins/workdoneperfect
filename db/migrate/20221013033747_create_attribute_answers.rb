class CreateAttributeAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :attribute_answers do |t|
      t.belongs_to :employee_template, null: false, foreign_key: true
      t.belongs_to :employee, null: false, foreign_key: true
      t.string :answer, null: false
      t.index [:employee_id, :employee_template_id], unique: true
      t.timestamps
    end
  end
end
