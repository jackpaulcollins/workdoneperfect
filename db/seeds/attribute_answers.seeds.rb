# frozen_string_literal: true

Employee.all.each do |employee|
  employee.employee_template.employee_attributes.each do |attribute|
    if employee.attribute_answers.find_by(employee_attribute: attribute).nil?
      employee.attribute_answers.create(employee_attribute: attribute,
                                        answer: Faker::Hipster.sentence(word_count: rand(1..10)))
    end
  end
end
