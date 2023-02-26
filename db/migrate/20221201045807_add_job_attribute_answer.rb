# frozen_string_literal: true

class AddJobAttributeAnswer < ActiveRecord::Migration[7.0]
  def change
    create_table :job_attribute_answers do |t|
      t.belongs_to :job_attribute, null: false, foreign_key: true
      t.belongs_to :job, null: false, foreign_key: true
      t.string :answer, null: false
      t.index %i[job_id job_attribute_id], unique: true, name: 'index_job_attribute_answers_on_job_and_attribute'
      t.timestamps
    end
  end
end
