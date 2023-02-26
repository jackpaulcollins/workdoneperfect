# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id                   :bigint           not null, primary key
#  email                :string
#  final_date           :datetime
#  first_name           :string           not null
#  last_name            :string
#  slug                 :string
#  start_date           :datetime
#  state                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  claimed_by_id        :bigint
#  employee_template_id :bigint           not null
#
# Indexes
#
#  index_employees_on_account_id            (account_id)
#  index_employees_on_claimed_by_id         (claimed_by_id) UNIQUE
#  index_employees_on_employee_template_id  (employee_template_id)
#  index_employees_on_slug                  (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (claimed_by_id => users.id)
#  fk_rails_...  (employee_template_id => employee_templates.id)
#
require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
