# frozen_string_literal: true

# == Schema Information
#
# Table name: job_attributes
#
#  id              :bigint           not null, primary key
#  data_type       :integer          not null
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  job_template_id :bigint           not null
#
# Indexes
#
#  index_job_attributes_on_job_template_id  (job_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_template_id => job_templates.id)
#
class JobAttribute < ApplicationRecord
  belongs_to :job_template
  has_many :job_attribute_answers, dependent: :destroy

  validates :name, presence: true
  validates :job_template, presence: true
  enum data_type: %i[text required integer]

  def fetch_answer(job_id)
    job_attribute_answers.find_by(job_id:)
  end

  def input_field
    case data_type
    when "text"
      "text_field"
    when "boolean"
      "checkbox"
    when "integer"
      "number"
    else
      "text_field"
    end
  end
end
