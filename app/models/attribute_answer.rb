# == Schema Information
#
# Table name: attribute_answers
#
#  id                   :bigint           not null, primary key
#  answer               :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  employee_id          :bigint           not null
#  employee_template_id :bigint           not null
#
# Indexes
#
#  index_attribute_answers_on_employee_id           (employee_id)
#  index_attribute_answers_on_employee_template_id  (employee_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (employee_template_id => employee_templates.id)
#
class AttributeAnswer < ApplicationRecord
  belongs_to :employee_template
  belongs_to :employee

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :attribute_answers, partial: "attribute_answers/index", locals: {attribute_answer: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :attribute_answers, target: dom_id(self, :index) }
end
