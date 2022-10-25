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

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :company_resources, partial: "company_resources/index", locals: {company_resource: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :company_resources, target: dom_id(self, :index) }
end
