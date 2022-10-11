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

# Template = [[attribute_name, data_type, required]]

class EmployeeTemplate < ApplicationRecord
  acts_as_tenant :account
  belongs_to :account
  belongs_to :user
  has_many :employees
  validates :template_attributes, :presence => true, length: { minimum: 1 }
  validates :account, :presence => true

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :templates, partial: "templates/index", locals: { template: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :templates, target: dom_id(self, :index) }
end
