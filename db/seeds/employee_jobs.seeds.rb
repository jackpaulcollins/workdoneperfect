Job.all.each do |job|
  unless job.employees.any?
    job.employees << Employee.all.to_a.sample(rand(1..5))
  end
end
