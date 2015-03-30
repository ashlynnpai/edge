Fabricator(:badgeinput) do
  treehouse_name { Faker::Internet.user_name }
  codeschool_name { Faker::Internet.user_name }
  codewars_name { Faker::Internet.user_name }
  github_name { Faker::Internet.user_name }

end