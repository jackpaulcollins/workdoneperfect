# == Schema Information
#
# Table name: jobs
#
#  id               :bigint           not null, primary key
#  compeleted_hours :integer
#  date             :datetime
#  estimated_hours  :integer
#  revenue          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint
#  customer_id      :bigint           not null
#
# Indexes
#
#  index_jobs_on_account_id   (account_id)
#  index_jobs_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
class Job < ApplicationRecord
  acts_as_tenant :account
  belongs_to :account
  belongs_to :customer
  has_and_belongs_to_many :employees

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :jobs, partial: "jobs/index", locals: { job: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :jobs, target: dom_id(self, :index) }
end
