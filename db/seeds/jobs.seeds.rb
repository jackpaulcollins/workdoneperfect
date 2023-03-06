# frozen_string_literal: true

Account.all.each do |account|
  rand(20).times do
    estimated_hours = rand(1..16)
    job = account.jobs.create({
      job_template_id: account.job_templates.sample.id,
      state: "staffed",
      customer: account.customers.sample,
      date_and_time: Faker::Date.between(from: 1.year.ago, to: Date.today + 1.month) + rand(7..10).hours,
      estimated_hours: rand(4..12),
      company_resources: rand(2..8).times.map { account.company_resources.sample },
      total_hours: nil,
    })

    job.job_template.job_attributes.each do |attribute|
      job.job_attribute_answers.create(job_attribute: attribute, answer: Faker::Hipster.sentence(word_count: rand(1..10)))
    end

    EmployeeJob.create({
      job_id: job.id,
      employee_id: account.employees.sample.id
    })

    next unless job.date_and_time < Date.today

    completed_at = Faker::Time.between(from: job.date_and_time + 8.hours, to: (job.date_and_time + 12.hours))
    hours = ((completed_at - job.date_and_time) / 3600).round
    job.update(
      completed_at:,
      total_hours: hours,
      revenue: hours * 250
    )
    job.complete!
  end
end

# probably an issue with sidekiq threading, and kicking off all the seeds at once
# but we end up creating attrs w/o answers, so this will clean it up

Job.find_each do |job|
  job.job_template.job_attributes.each do |a|
    answer = a.fetch_answer(job.id)
    a.destroy! if answer.nil?
  end
end
