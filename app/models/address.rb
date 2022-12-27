# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  address_type     :integer
#  addressable_type :string           not null
#  city             :string
#  country          :string
#  line1            :string
#  line2            :string
#  postal_code      :string
#  state            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :address_type, :line1, :city, :postal_code, :country, presence: true

  enum address_type: %i[billing shipping]

  after_commit -> { addressable.pay_customers.each(&:update_customer!) }

  def to_stripe
    {
      city:,
      country:,
      line1:,
      line2:,
      postal_code:,
      state:
    }
  end
end
