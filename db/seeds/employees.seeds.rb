EmployeeTemplate.all.each do |employee_template|
  unless employee_template.employees.any?
    rand(10..30).times do
      employee = employee_template.employees.create({
        account: employee_template.account,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        start_date: Faker::Date.between(from: 5.years.ago, to: Date.today)
      })

      # 25% chance the employee is no longer with the company
      if rand(1..4) == 1
        employee.update(final_date: Faker::Date.between(from: employee.start_date, to: Date.today))
      end
    end
  end
end
