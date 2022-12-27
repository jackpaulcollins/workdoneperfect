# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id              :bigint           not null, primary key
#  completed_at    :datetime
#  date_and_time   :datetime         not null
#  estimated_hours :float
#  revenue         :float
#  state           :string
#  total_hours     :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint           not null
#  customer_id     :bigint           not null
#  job_template_id :bigint
#
# Indexes
#
#  index_jobs_on_account_id       (account_id)
#  index_jobs_on_customer_id      (customer_id)
#  index_jobs_on_job_template_id  (job_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (customer_id => customers.id)
#
require "test_helper"

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
