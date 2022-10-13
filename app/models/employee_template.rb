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
class EmployeeTemplate < ApplicationRecord
  belongs_to :account
  has_many :employees, dependent: :destroy

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :employee_templates, partial: "employee_templates/index", locals: {employee_template: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :employee_templates, target: dom_id(self, :index) }
end
