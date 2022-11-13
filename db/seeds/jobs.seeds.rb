Account.all.each do |account|
  unless account.jobs.any?
    rand(500..1000).times do
      estimated_hours = rand(1..16)
      account.jobs.create({
        customer: account.customers.sample,
        date_and_time: Faker::Date.between(from: 5.years.ago, to: Date.today),
        estimated_hours: estimated_hours,
        total_hours: rand((estimated_hours - 5)..(estimated_hours + 5)),
        revenue: Faker::Number.decimal(l_digits: rand(3..4), r_digits: 2),
        company_resources: rand(2..8).times.map { account.company_resources.sample }
      })
    end
  end
end
