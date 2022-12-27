# frozen_string_literal: true

# Drip API Client
# http://localhost:3000/jumpstart/docs/integrations
#
# Example usage:
# Jumpstart::Clients.drip.create_or_update_subscriber(email, options={})

client = Drip::Client.new do |c|
  c.api_key = Rails.application.credentials.dig(:drip, :api_key)
  c.account_id = Rails.application.credentials.dig(:drip, :account_id)
end

Jumpstart::Clients.drip = client
