# frozen_string_literal: true

json.extract! employee, :id, :account_id, :employee_template_id, :first_name, :last_name, :start_date, :final_date,
              :created_at, :updated_at
json.url employee_url(employee, format: :json)
