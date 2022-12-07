class JobAttributeAnswer < ApplicationRecord
  belongs_to :job_attribute
  belongs_to :job

  validates :job_attribute, uniqueness: {scope: :job_id}
  validates :answer, presence: true
end
