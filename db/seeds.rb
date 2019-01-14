# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(username:  "ExampleUser",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin:     true,
    activated: true,
    activated_at: Time.zone.now)

99.times do |n|
        dummyusername  = Faker::Name.first_name + Faker::Name.last_name
        email = "example-#{n+1}@railstutorial.org"
        password = "password"
        User.create!(username:  dummyusername,
                     email: email,
                     password:              password,
                     password_confirmation: password,
                     activated: true,
                     activated_at: Time.zone.now)
end

(1..100).each do |i|
    Micropost.create!(user_id: "1", content: %{
        #{i}. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In feugiat purus
    })
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }