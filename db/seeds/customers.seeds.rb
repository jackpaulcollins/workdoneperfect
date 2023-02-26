# frozen_string_literal: true

Account.all.each do |account|
  next if account.customers.any?

  rand(50..100).times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.first_name
    email = Faker::Internet.email(name: "#{first_name} #{last_name}")
    phone_number = Faker::PhoneNumber.cell_phone
    customer = account.customers.create({
                                          email:
                                        })

    customer.update(first_name:) if [true, false].sample
    customer.update(last_name:) if [true, false].sample
    customer.update(phone_number:) if [true, false].sample
  end
end
