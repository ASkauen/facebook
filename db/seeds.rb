# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name ,email: Faker::Internet.email, password: "123123")
  user.set_avatar("https://i.pravatar.cc/150?u=#{user.email}")
  puts "Created user #{user.full_name}"
end