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
class Customer < ApplicationRecord
  acts_as_tenant :account

  has_person_name

  belongs_to :account
  has_many :jobs, dependent: :destroy

  validates :email, presence: true, uniqueness: {scope: :account_id}

  def has_name?
    first_name.present? || last_name.present?
  end

  def name_and_email_or_email
    has_name? ? "#{first_name} #{last_name} | #{email}" : email
  end

  def job_count
    jobs.count
  end

  def most_recent_job
    jobs.order(:date_and_time).first!
  end

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :customers, partial: "customers/index", locals: {customer: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :customers, target: dom_id(self, :index) }
end
