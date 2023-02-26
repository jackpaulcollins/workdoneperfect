# frozen_string_literal: true

EmployeeTemplate.all.each do |employee_template|
  next if employee_template.employees.any?

  rand(10..30).times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    employee = employee_template.employees.create({
      account: employee_template.account,
      email: Faker::Internet.email(name: "#{first_name} #{last_name}"),
      first_name:,
      last_name:,
      start_date: Faker::Date.between(from: 5.years.ago, to: Date.today)
    })

    # 25% chance the employee is no longer with the company
    employee.update(final_date: Faker::Date.between(from: employee.start_date, to: Date.today)) if rand(1..4) == 1
  end
end
