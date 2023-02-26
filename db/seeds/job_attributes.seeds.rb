# frozen_string_literal: true

JobTemplate.all.each do |job_template|
  next if job_template.job_attributes.any?

  rand(1..10).times do
    job_template.job_attributes.create({
                                         name: Faker::Hipster.sentence(word_count: rand(1..3)),
                                         data_type: %i[text required integer].sample
                                       })
  end
end
