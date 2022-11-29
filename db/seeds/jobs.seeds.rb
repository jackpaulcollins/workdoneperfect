Account.all.each do |account|
  unless account.jobs.any?
    rand(500..1000).times do
      estimated_hours = rand(1..16)
      job = account.jobs.create({
        customer: account.customers.sample,
        date_and_time: Faker::Date.between(from: 5.years.ago, to: Date.today + 1.month),
        estimated_hours: estimated_hours,
        company_resources: rand(2..8).times.map { account.company_resources.sample }
      })

      if job.date_and_time < Date.today
        completed_at = Faker::Time.between(from: job.date_and_time, to: (job.date_and_time + 12.hours))
        hours = ((completed_at - job.date_and_time) / 3600).round
        job.update(
          completed_at: completed_at,
          total_hours: hours,
          revenue: hours * 250
        )
      end
    end
  end
end
