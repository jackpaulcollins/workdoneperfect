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
require "test_helper"

class EmployeeAttributeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
