# frozen_string_literal: true

json.extract! customer, :id, :account_id, :email, :first_name, :last_name, :phone_number, :created_at, :updated_at
json.url customer_url(customer, format: :json)
