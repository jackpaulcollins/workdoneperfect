# frozen_string_literal: true

EmployeeTemplate.all.each do |employee_template|
  next if employee_template.employee_attributes.any?

  rand(1..10).times do
    employee_template.employee_attributes.create({
      name: Faker::Hipster.sentence(word_count: rand(1..3))
    })
  end
end
