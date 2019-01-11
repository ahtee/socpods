# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 
User.create!(username:  "ExampleUser",
    email: "example@railstutorial.org",
    password:              "foobar12",
    password_confirmation: "foobar12",
    admin:     true,
    activated: true,
    activated_at: Time.zone.now)
