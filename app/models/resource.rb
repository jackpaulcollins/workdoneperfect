# == Schema Information
#
# Table name: resources
#
#  id          :bigint           not null, primary key
#  count       :integer
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint           not null
#
# Indexes
#
#  index_resources_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Resource < ApplicationRecord
  belongs_to :account
  acts_as_tenant :account

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :resources, partial: "resources/index", locals: {resource: self} }
  after_update_commit -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :resources, target: dom_id(self, :index) }
end
