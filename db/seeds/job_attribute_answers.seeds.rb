# frozen_string_literal: true

Job.all.each do |job|
  job.job_template.job_attributes.each do |attribute|
    if job.job_attribute_answers.find_by(job_attribute: attribute).nil?
      job.job_attribute_answers.create(job_attribute: attribute,
                                       answer: Faker::Hipster.sentence(word_count: rand(1..10)))
    end
  end
end
