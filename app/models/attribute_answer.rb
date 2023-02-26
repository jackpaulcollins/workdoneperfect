# frozen_string_literal: true

# == Schema Information
#
# Table name: attribute_answers
#
#  id                    :bigint           not null, primary key
#  answer                :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  employee_attribute_id :bigint           not null
#  employee_id           :bigint           not null
#
# Indexes
#
#  index_attribute_answers_on_employee_and_attribute  (employee_id,employee_attribute_id) UNIQUE
#  index_attribute_answers_on_employee_attribute_id   (employee_attribute_id)
#  index_attribute_answers_on_employee_id             (employee_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_attribute_id => employee_attributes.id)
#  fk_rails_...  (employee_id => employees.id)
#
class AttributeAnswer < ApplicationRecord
  belongs_to :employee_attribute
  belongs_to :employee

  validates :employee_attribute, uniqueness: {scope: :employee_id}
  validates :answer, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit lambda {
                        broadcast_prepend_later_to :attribute_answers, partial: "attribute_answers/index",
                          locals: {attribute_answer: self}
                      }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :attribute_answers, target: dom_id(self, :index) }
end
