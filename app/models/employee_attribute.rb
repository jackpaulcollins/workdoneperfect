# == Schema Information
#
# Table name: employee_attributes
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  employee_template_id :bigint           not null
#
# Indexes
#
#  index_employee_attributes_on_employee_template_id  (employee_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_template_id => employee_templates.id)
#
class EmployeeAttribute < ApplicationRecord
  belongs_to :employee_template

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :employee_attributes, partial: "employee_attributes/index", locals: {employee_attribute: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :employee_attributes, target: dom_id(self, :index) }
end
