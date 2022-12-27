# frozen_string_literal: true

Account.all.each do |account|
  next if account.jobs.any?

  rand(500..1000).times do
    estimated_hours = rand(1..16)
    job = account.jobs.create({
      job_template_id: account.job_templates.sample.id,
      state: "staffed",
      customer: account.customers.sample,
      date_and_time: Faker::Date.between(from: 5.years.ago, to: Date.today + 1.month),
      estimated_hours:,
      company_resources: rand(2..8).times.map { account.company_resources.sample }
    })

    EmployeeJob.create({
      job_id: job.id,
      employee_id: account.employees.sample.id
    })

    next unless job.date_and_time < Date.today

    job.complete!
    completed_at = Faker::Time.between(from: job.date_and_time, to: (job.date_and_time + 12.hours))
    hours = ((completed_at - job.date_and_time) / 3600).round
    job.update(
      completed_at:,
      total_hours: hours,
      revenue: hours * 250
    )
  end
end
