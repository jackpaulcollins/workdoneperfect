# frozen_string_literal: true

USERS = [
  {
    name: 'Jace Bayless',
    email: 'jacebayless@gmail.com'
  },
  {
    name: 'Jack Collins',
    email: 'jackpaulcollins@gmail.com'
  }
].freeze

USERS.each do |user|
  next if User.find_by(email: user[:email])

  User.create({
                name: user[:name],
                email: user[:email],
                password: 'password',
                password_confirmation: 'password',
                admin: true,
                terms_of_service: true
              })
end
