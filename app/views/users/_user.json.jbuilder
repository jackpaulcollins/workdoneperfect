# frozen_string_literal: true

json.cache! [user] do
  json.extract! user, :id, :name
  json.avatar_url avatar_url_for(user)
  json.sgid user.attachable_sgid
  json.content render(partial: "users/user", locals: {user:}, formats: [:html])
end
