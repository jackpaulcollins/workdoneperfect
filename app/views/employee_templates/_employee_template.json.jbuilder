# frozen_string_literal: true

json.extract! employee_template, :id, :account_id, :title, :created_at, :updated_at
json.url employee_template_url(employee_template, format: :json)
