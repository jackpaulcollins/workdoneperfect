# == Schema Information
#
# Table name: employees
#
#  id         :bigint           not null, primary key
#  driver     :boolean
#  name       :string
#  position   :string
#  start_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_employees_on_account_id  (account_id)
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