Fabricator(:review) do
  content { Faker::Lorem.paragraph(2) }
  enrollment "completed"
end


