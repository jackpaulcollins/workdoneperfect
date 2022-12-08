# == Schema Information
#
# Table name: jobs
#
#  id              :bigint           not null, primary key
#  completed_at    :datetime
#  date_and_time   :datetime         not null
#  estimated_hours :float
#  revenue         :float
#  state           :string
#  total_hours     :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  customer_id     :bigint           not null
#  job_template_id :bigint
#
# Indexes
#
#  index_jobs_on_account_id       (account_id)
#  index_jobs_on_customer_id      (customer_id)
#  index_jobs_on_job_template_id  (job_template_id)
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
  belongs_to :job_template
  has_many :employee_jobs, dependent: :destroy
  has_many :employees, through: :employee_jobs
  has_many :job_attribute_answers, dependent: :destroy
  has_many :resource_schedules, dependent: :delete_all
  has_many :company_resources, through: :resource_schedules

  validates :date_and_time, presence: true

  accepts_nested_attributes_for :job_attribute_answers, allow_destroy: true

  # since we index on answer_job, we need to destroy outgoing answers
  # when a template is being changed
  # before we validate the object
  before_validation :maybe_discard_stale_answers, if: :template_changing?

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :jobs, partial: "jobs/index", locals: {job: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :jobs, target: dom_id(self, :index) }

  scope :completed, ->(completed = true) { where("completed_at IS NOT NULL") if completed }

  # :draft, :scheduled, :staffed (employees added), :canceled or :completed

  state_machine :initial => :draft do
    event :schedule do
      transition :draft => :scheduled
    end
  end



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

  def attributes_and_answers
    job_template&.job_attributes&.map do |attribute|
      {
        name: attribute.name,
        answer: job_attribute_answers.find_by(job_attribute: attribute)&.answer
      }
    end
  end

  def template_changing?
    job_template_changed?
  end

  def maybe_discard_stale_answers
    job_attribute_answers.where(job_id: self).destroy_all
  end
end
