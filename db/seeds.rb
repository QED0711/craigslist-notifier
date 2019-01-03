# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).



user = User.create(email: ENV["test_user_1_email"], password: ENV["test_user_1_password"], authorization: "admin")


# if you add any searches above this line, make sure to uncomment the line below. 
# Crawler.delay(run_at: 5.minutes.from_now).run_searches