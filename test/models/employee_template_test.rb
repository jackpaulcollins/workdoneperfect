# == Schema Information
#
# Table name: employee_templates
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_employee_templates_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class EmployeeTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
