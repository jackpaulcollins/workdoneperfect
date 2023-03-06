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
end
