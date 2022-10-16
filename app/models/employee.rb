# == Schema Information
#
# Table name: employees
#
#  id                   :bigint           not null, primary key
#  email                :string
#  final_date           :datetime
#  first_name           :string           not null
#  last_name            :string
#  start_date           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  employee_template_id :bigint           not null
#
# Indexes
#
#  index_employees_on_account_id            (account_id)
#  index_employees_on_employee_template_id  (employee_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (employee_template_id => employee_templates.id)
#
class Employee < ApplicationRecord
  acts_as_tenant :account

  has_person_name

  acts_as_tenant :account
  belongs_to :account
  belongs_to :employee_template
  has_many :attribute_answers, dependent: :destroy
  has_many :employee_jobs, dependent: :destroy
  has_many :jobs, through: :employee_jobs

  validates :email, format: User.email_regexp, allow_blank: true

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new("||",
      parent.table[:first_name], parent.table[:last_name])
  end

  # Broadcast changes in realtime with Hotwire
  after_create_commit do
    broadcast_prepend_later_to :employees, partial: "employees/index", locals: {employee: self} # Append to index
  end

  after_update_commit do
    broadcast_replace_later_to self, partial: "employees/detailed_employee", locals: {employee: self} # Update the show
    broadcast_replace_later_to :employees, target: dom_id(self, :index) # Update the index
  end

  after_destroy_commit do
    broadcast_remove_to :employees, target: dom_id(self, :index) # Remove from the index
  end
end
