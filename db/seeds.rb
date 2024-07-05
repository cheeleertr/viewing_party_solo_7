# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# create Users
10.times do 
   User.create!(name: Faker::Name.name, email: Faker::Internet.email)
end

# create Parties
2.times do 
   ViewingParty.create!(duration: rand(200..240), 
   date: Faker::Date.forward(days: rand(1..14)), 
   start_time: Time.new.strftime("%H:%M"),
   movie_id: 122, 
   movie_title: "The Lord of the Rings: The Return of the King", 
   movie_poster_path: "/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg" 
   )
end
2.times do 
   ViewingParty.create!(duration: rand(200..240), 
   date: Faker::Date.forward(days: rand(1..14)), 
   start_time: Time.new.strftime("%H:%M"),
   movie_id: 138, 
   movie_title: "The Godfather", 
   movie_poster_path: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg" 
   )
end
ViewingParty.create!(duration: rand(200..240), 
date: Faker::Date.forward(days: rand(1..14)), 
start_time: Time.new.strftime("%H:%M"),
movie_id: 157336, 
movie_title: "Interstellar", 
movie_poster_path: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg" 
)

# set Hosts 
UserParty.create!(viewing_party: ViewingParty.first, user: User.first, host: true)
UserParty.create!(viewing_party: ViewingParty.second, user: User.second, host: true)
UserParty.create!(viewing_party: ViewingParty.third, user: User.third, host: true)
UserParty.create!(viewing_party: ViewingParty.fourth, user: User.fourth, host: true)
UserParty.create!(viewing_party: ViewingParty.last, user: User.fifth, host: true)

# set invites
UserParty.create!(viewing_party: ViewingParty.first, user: User.second, host: false)
UserParty.create!(viewing_party: ViewingParty.first, user: User.third, host: false)
UserParty.create!(viewing_party: ViewingParty.second, user: User.fourth, host: false)
UserParty.create!(viewing_party: ViewingParty.second, user: User.fourth, host: false)
UserParty.create!(viewing_party: ViewingParty.last, user: User.second, host: false)
UserParty.create!(viewing_party: ViewingParty.last, user: User.first, host: false)
UserParty.create!(viewing_party: ViewingParty.last, user: User.last, host: false)