# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id           :bigint           not null, primary key
#  email        :string           not null
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint           not null
#
# Indexes
#
#  index_customers_on_account_id            (account_id)
#  index_customers_on_email_and_account_id  (email,account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
