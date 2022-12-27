# frozen_string_literal: true

class CreateEmployeeJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_jobs do |t|
      t.belongs_to :job, null: false, foreign_key: true
      t.belongs_to :employee, null: false, foreign_key: true
      t.index %i[job_id employee_id], unique: true
      t.timestamps
    end
  end
end
