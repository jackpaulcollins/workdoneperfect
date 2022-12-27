# frozen_string_literal: true

json.extract! company_resource, :id, :name, :description, :account_id, :count, :created_at, :updated_at
json.url company_resource_url(company_resource, format: :json)
