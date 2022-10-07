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
class Employee < ApplicationRecord
  acts_as_tenant :account
  belongs_to :account

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :employees, partial: "employees/index", locals: { employee: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :employees, target: dom_id(self, :index) }
end
