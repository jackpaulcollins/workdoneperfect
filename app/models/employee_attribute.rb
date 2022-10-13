# == Schema Information
#
# Table name: employee_attributes
#
#  id                   :bigint           not null, primary key
#  data_type            :integer
#  name                 :string           not null
#  required             :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint
#  employee_template_id :bigint           not null
#
# Indexes
#
#  index_employee_attributes_on_account_id            (account_id)
#  index_employee_attributes_on_employee_template_id  (employee_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_template_id => employee_templates.id)
#
class EmployeeAttribute < ApplicationRecord
  acts_as_tenant :account
  belongs_to :account
  belongs_to :employee_template
  validates :name, presence: true
  validates :employee_template, presence: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :employee_attributes, partial: "employee_attributes/index", locals: {employee_attribute: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :employee_attributes, target: dom_id(self, :index) }

  enum data_type: [:text, :boolean, :integer]
end

# (name: "driver", data_type: "boolean", required: boolean)
