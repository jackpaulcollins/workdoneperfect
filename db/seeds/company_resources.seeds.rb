Account.all.each do |account|
  rand(5..25).times do
    name = Faker::Name.first_name
    description = Faker::Name.first_name
    account.company_resources.create({
      name: name,
      description: description
    })
  end
end
