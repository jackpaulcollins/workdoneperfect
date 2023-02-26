# frozen_string_literal: true

# == Schema Information
#
# Table name: job_attribute_answers
#
#  id               :bigint           not null, primary key
#  answer           :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  job_attribute_id :bigint           not null
#  job_id           :bigint           not null
#
# Indexes
#
#  index_job_attribute_answers_on_job_and_attribute  (job_id,job_attribute_id) UNIQUE
#  index_job_attribute_answers_on_job_attribute_id   (job_attribute_id)
#  index_job_attribute_answers_on_job_id             (job_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_attribute_id => job_attributes.id)
#  fk_rails_...  (job_id => jobs.id)
#
class JobAttributeAnswer < ApplicationRecord
  belongs_to :job_attribute
  belongs_to :job

  validates :job_attribute, uniqueness: { scope: :job_id }
  validates :answer, presence: true
end
