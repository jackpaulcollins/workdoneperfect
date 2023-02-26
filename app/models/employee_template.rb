# frozen_string_literal: true

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
#  index_employee_templates_on_account_id            (account_id)
#  index_employee_templates_on_title_and_account_id  (title,account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class EmployeeTemplate < ApplicationRecord
  acts_as_tenant :account

  belongs_to :account
  has_many :employees, dependent: :destroy
  has_many :employee_attributes, index_errors: true, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :account_id }

  accepts_nested_attributes_for :employee_attributes, allow_destroy: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit lambda {
                        broadcast_prepend_later_to :employee_templates, partial: 'employee_templates/index',
                                                                        locals: { employee_template: self }
                      }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :employee_templates, target: dom_id(self, :index) }

  def employee_count
    employees.count
  end
end
