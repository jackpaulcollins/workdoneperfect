# == Schema Information
#
# Table name: jobs
#
#  id               :bigint           not null, primary key
#  compeleted_hours :integer
#  date             :datetime
#  estimated_hours  :integer
#  revenue          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint
#  customer_id      :bigint           not null
#
# Indexes
#
#  index_jobs_on_account_id   (account_id)
#  index_jobs_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
require "test_helper"

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
