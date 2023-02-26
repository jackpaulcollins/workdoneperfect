# frozen_string_literal: true

json.extract! job, :id, :account_id, :customer_id, :date_and_time, :estimated_hours, :total_hours, :revenue,
              :created_at, :updated_at
json.url job_url(job, format: :json)
