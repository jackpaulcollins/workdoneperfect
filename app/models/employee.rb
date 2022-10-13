# == Schema Information
#
# Table name: employees
#
#  id                   :bigint           not null, primary key
#  final_date           :datetime
#  first_name           :string
#  last_name            :string
#  start_date           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  employee_template_id :bigint           not null
#
# Indexes
#
#  index_employees_on_account_id            (account_id)
#  index_employees_on_employee_template_id  (employee_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (employee_template_id => employee_templates.id)
#
class Employee < ApplicationRecord
  has_person_name

  belongs_to :account
  belongs_to :employee_template

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :employees, partial: "employees/index", locals: {employee: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :employees, target: dom_id(self, :index) }
end
