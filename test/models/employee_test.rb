# == Schema Information
#
# Table name: employees
#
#  id                   :bigint           not null, primary key
#  attributes_finished  :boolean          default(FALSE)
#  first_name           :string
#  last_name            :string
#  start_date           :date
#  template_attributes  :jsonb
#  termination_date     :date
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  employee_template_id :bigint
#
# Indexes
#
#  index_employees_on_account_id            (account_id)
#  index_employees_on_employee_template_id  (employee_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
