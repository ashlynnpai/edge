Fabricator(:course) do
  name { Faker::Lorem.paragraph(2) }
  institution { Faker::Lorem.paragraph(2) }
end