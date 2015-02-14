Fabricator(:user) do
  email { Faker::Internet.email }
  password "password"
  password_confirmation "password"
  name { Faker::Name.name }
end