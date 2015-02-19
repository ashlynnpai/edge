Fabricator(:post) do
  title { Faker::Lorem.paragraph(1) }
  content { Faker::Lorem.paragraph(2) }
end