# frozen_string_literal: true

Job.all.each do |job|
  job.employees << Employee.all.to_a.sample(rand(1..5)) unless job.employees.any?
end
