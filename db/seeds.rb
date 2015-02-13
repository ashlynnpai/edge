

User.create(name: "Happy Hippo", password: "password1", password_confirmation: "password1", email: "user1@example.com", admin: "true")
#User.create(name: "Smiley Small", password: "password2", email: "user2@example.com", admin: "false")

Course.create(name: "Swimming", provider: "Swim School")

UserCourse.create(user_id: 1, course_id: 1, status: "completed", course_creator: "true")
#UserCourse.create(user_id: 2, course_id: 1, status: "current", course_creator: "false")
