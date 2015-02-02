Fabricator(:course) do
  name { Faker::Lorem.paragraph(2) }
  provider { Faker::Lorem.paragraph(2) }
end