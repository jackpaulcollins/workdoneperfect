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
#  index_employee_jobs_on_employee_id  (employee_id)
#  index_employee_jobs_on_job_id       (job_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (job_id => jobs.id)
#
class EmployeeJob < ApplicationRecord
  belongs_to :job
  belongs_to :employee

  validates :job, uniqueness: {scope: :employee_id}

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :employee_jobs, partial: "employee_jobs/index", locals: {employee_job: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :employee_jobs, target: dom_id(self, :index) }
end
