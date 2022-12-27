# frozen_string_literal: true

# == Schema Information
#
# Table name: company_resources
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#
# Indexes
#
#  index_company_resources_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class CompanyResource < ApplicationRecord
  belongs_to :account
  acts_as_tenant :account
  has_many :resource_schedules, inverse_of: :company_resource, dependent: :destroy
  has_many :jobs, through: :resource_schedules

  def job_usage_count
    resource_schedules.count
  end
end
