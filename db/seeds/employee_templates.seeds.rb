Account.all.each do |account|
  delta = 3 - account.employee_templates.count
  delta.times do
    account.employee_templates.create({
      title: Faker::Hipster.sentence(word_count: rand(1..3))
    })
  end
end
