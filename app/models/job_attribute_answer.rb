class JobAttributeAnswer < ApplicationRecord
  belongs_to :job_attribute
  belongs_to :job

  validates :job_attribute, uniqueness: {scope: :job_id}
  validates :answer, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :job_attribute_answers, partial: "job_attribute_answers/index", locals: {job_attribute_answer: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :job_attribute_answers, target: dom_id(self, :index) }
end
