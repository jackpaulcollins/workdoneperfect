# == Schema Information
#
# Table name: employee_templates
#
#  id                  :bigint           not null, primary key
#  template_attributes :string           default([]), is an Array
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  account_id          :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_employee_templates_on_account_id  (account_id)
#  index_employee_templates_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class EmployeeTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
