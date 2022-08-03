# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Like.destroy_all
Review.destroy_all
Idea.destroy_all
User.destroy_all


PASSWORD = "123"
super_user = User.create(
  name: "Admin",
  email: "admin@user.com",
  password: PASSWORD,
  is_admin: true
)


10.times do
  name = Faker::Name.name
  User.create(
    name: name,
    email: "#{name}@outlook.com",
    password: PASSWORD
  )
end

users = User.all

20.times do
  created_at = Faker::Date.backward(days:365 * 5)
  i = Idea.create(
    title: Faker::Hacker.say_something_smart,
    description: Faker::ChuckNorris.fact,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
   )
  i.likers = users.shuffle.slice(0, rand(users.count))

  if i.valid?
    rand(1..5).times do
      Review.create(body: Faker::Hacker.say_something_smart, idea:i, user: users.sample)
    end
  end

end


ideas = Idea.all
reviews = Review.all

p "created #{ideas.count} ideas, #{users.count} users, #{reviews.count} reviews, #{Like.count} likes"

