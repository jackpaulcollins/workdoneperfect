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
  # has_many :attribute_answers, dependent: :destroy

  validates :name, presence: true
  validates :job_template, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :job_attributes, partial: "job_attributes/index", locals: {job_attribute: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :job_attributes, target: dom_id(self, :index) }

  enum data_type: [:text, :boolean, :integer]
end
