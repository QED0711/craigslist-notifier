# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create(email: "qdizon@gmail.com", password: "123", authorization: "admin")

user.searches.create(url: "https://washingtondc.craigslist.org/search/vga?query=pc", description: "pc video game listings in DC")
user.searches.create(url: "https://washingtondc.craigslist.org/d/electronics/search/ela", description: "Electronics in DC")