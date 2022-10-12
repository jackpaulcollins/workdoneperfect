# == Schema Information
#
# Table name: customers
#
#  id           :bigint           not null, primary key
#  email        :string
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint
#
# Indexes
#
#  index_customers_on_account_id  (account_id)
#
class Customer < ApplicationRecord
  acts_as_tenant :account
  belongs_to :account
  has_many :jobs

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :customers, partial: "customers/index", locals: { customer: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :customers, target: dom_id(self, :index) }

  def name_with_email
    first_name + " " + last_name + " | " + email
  end
end
