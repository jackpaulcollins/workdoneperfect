# frozen_string_literal: true

Account.all.each do |account|
  5.times do
    account.job_templates.create({
      title: Faker::Hipster.sentence(word_count: rand(1..3)),
      default_template: false,
      required_resources: []
    })
  end
end
