# == Schema Information
#
# Table name: jobs
#
#  id              :bigint           not null, primary key
#  completed_at    :datetime
#  date_and_time   :datetime         not null
#  estimated_hours :float
#  revenue         :float
#  total_hours     :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  customer_id     :bigint           not null
#
# Indexes
#
#  index_jobs_on_account_id   (account_id)
#  index_jobs_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (customer_id => customers.id)
#
class Job < ApplicationRecord
  acts_as_tenant :account

  belongs_to :account
  belongs_to :customer
  has_many :employee_jobs, dependent: :destroy
  has_many :employees, through: :employee_jobs
  has_many :resource_schedules, dependent: :destroy
  has_many :company_resources, through: :resource_schedules

  validates :date_and_time, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :jobs, partial: "jobs/index", locals: {job: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :jobs, target: dom_id(self, :index) }

  scope :completed, ->(completed = true) { where("completed_at IS NOT NULL") if completed }
  default_scope { order("completed_at DESC") }

  # class methods
  class << self
    def incomplete
      completed.invert_where
    end
  end

  def completed?
    completed_at.present?
  end

  def incomplete?
    completed_at.nil?
  end
end
