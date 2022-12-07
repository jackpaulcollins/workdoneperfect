# == Schema Information
#
# Table name: job_templates
#
#  id                 :bigint           not null, primary key
#  default_template   :boolean          default(FALSE)
#  required_resources :string           default([]), is an Array
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_id         :bigint           not null
#
# Indexes
#
#  index_job_templates_on_account_id            (account_id)
#  index_job_templates_on_title_and_account_id  (title,account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class JobTemplate < ApplicationRecord
  validates_with JobTemplateValidator
  include DefaultTemplateConcern

  acts_as_tenant :account

  belongs_to :account
  has_many :jobs
  has_many :job_attributes, index_errors: true, dependent: :destroy

  validates :title, presence: true, uniqueness: {scope: :account_id}
  accepts_nested_attributes_for :job_attributes, allow_destroy: true

  before_validation :maybe_unset_default

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :job_templates, partial: "job_templates/index", locals: {job_template: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :job_templates, target: dom_id(self, :index) }

  class << self
    def default_template
      template = self.where(default_template: true)
      template.present? ? template.first : nil
    end
  end

  def job_count
    jobs.count
  end

  def maybe_unset_default
    if default_template_present? && default_template
      JobTemplate.default_template.update(default_template: false)
    end
  end
end
