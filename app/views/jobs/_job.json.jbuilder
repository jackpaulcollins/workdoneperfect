json.extract! job, :id, :customer_id, :employees_id, :date, :estimated_hours, :compeleted_hours, :revenue, :created_at, :updated_at
json.url job_url(job, format: :json)
