json.extract! employee, :id, :name, :position, :start_date, :driver, :created_by_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
