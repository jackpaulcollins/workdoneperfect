class JobTemplate < ApplicationRecord
  acts_as_tenant :account

  belongs_to :account
  has_many :jobs, dependent: :destroy
  has_many :job_attributes, index_errors: true, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :account_id}

  accepts_nested_attributes_for :jobs_attributes

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :job_templates, partial: "job_templates/index", locals: {job_template: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :job_templates, target: dom_id(self, :index) }

  def job_count
    jobs.count
  end
end
