# frozen_string_literal: true

# == Schema Information
#
# Table name: employee_jobs
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :bigint           not null
#  job_id      :bigint           not null
#
# Indexes
#
#  index_employee_jobs_on_employee_id             (employee_id)
#  index_employee_jobs_on_job_id                  (job_id)
#  index_employee_jobs_on_job_id_and_employee_id  (job_id,employee_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (job_id => jobs.id)
#
require "test_helper"

class EmployeeJobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
