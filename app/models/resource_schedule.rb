# == Schema Information
#
# Table name: resource_schedules
#
#  job_date            :date
#  company_resource_id :bigint           not null
#  job_id              :bigint           not null
#
# Indexes
#
#  company_resource_job_schedule                               (company_resource_id,job_id,job_date) UNIQUE
#  index_resource_schedules_on_company_resource_id_and_job_id  (company_resource_id,job_id)
#  index_resource_schedules_on_job_id_and_company_resource_id  (job_id,company_resource_id)
#
class ResourceSchedule < ApplicationRecord
  belongs_to :job
  belongs_to :company_resource
end
