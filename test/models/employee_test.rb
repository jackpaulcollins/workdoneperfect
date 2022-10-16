# == Schema Information
#
# Table name: employees
#
#  id                   :bigint           not null, primary key
#  email                :string
#  final_date           :datetime
#  first_name           :string           not null
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
require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
