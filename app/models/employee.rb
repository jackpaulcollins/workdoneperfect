# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id                   :bigint           not null, primary key
#  email                :string
#  final_date           :datetime
#  first_name           :string           not null
#  last_name            :string
#  slug                 :string
#  start_date           :datetime
#  state                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :bigint           not null
#  claimed_by_id        :bigint
#  employee_template_id :bigint           not null
#
# Indexes
#
#  index_employees_on_account_id            (account_id)
#  index_employees_on_claimed_by_id         (claimed_by_id) UNIQUE
#  index_employees_on_employee_template_id  (employee_template_id)
#  index_employees_on_slug                  (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (claimed_by_id => users.id)
#  fk_rails_...  (employee_template_id => employee_templates.id)
#
class Employee < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_tenant :account
  belongs_to :account
  belongs_to :employee_template
  belongs_to :claimed_by, class_name: "User", optional: true
  has_many :attribute_answers, dependent: :destroy
  has_many :employee_jobs, inverse_of: :employee, dependent: :destroy
  has_many :jobs, through: :employee_jobs

  accepts_nested_attributes_for :attribute_answers

  validates :email, format: User.email_regexp, allow_blank: true
  validates :first_name, presence: true

  scope :active, ->(active = true) { where("final_date IS NULL OR final_date > ?", Date.today) if active }
  scope :pending, -> { where(state: "pending") }

  state_machine initial: :unclaimed do
    event :mark_pending_invite do
      transition unclaimed: :pending
    end

    event :claim do
      transition pending: :claimed
    end
  end

  def self.ransackable_scopes(_auth_object = nil)
    [:active]
  end

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new("||",
      parent.table[:first_name], parent.table[:last_name])
  end

  def name
    "#{first_name} #{last_name}"
  end

  def attributes_and_answers
    employee_template.employee_attributes.map do |attribute|
      {
        name: attribute.name,
        answer: attribute_answers.find_by(employee_attribute: attribute)&.answer
      }
    end
  end

  # Broadcast changes in realtime with Hotwire
  after_create_commit do
    broadcast_prepend_later_to :employees, partial: "employees/index", locals: {employee: self} # Append to index
  end

  after_update_commit do
    broadcast_replace_later_to self # Update the show
    broadcast_replace_later_to :employees, target: dom_id(self, :index), partial: "employees/index", locals: {employee: self} # Update the index
  end

  after_destroy_commit do
    broadcast_remove_to :employees, target: dom_id(self, :index) # Remove from the index
  end
end
