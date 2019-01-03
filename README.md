# README

The CL Notifier App is created and maintained by Quinn Dizon. This is a non-comercial, open source project that was primarily created for fun and learning.

Why use the CL Notifier App?
Depending on what you are searching for on Craigslist, you might have a lot of competition from other people in your area. Listings can be posted and claimed within a matter or minutes. The CL Notifier App makes it easy for you to get notifications of new, relevant listings within minutes of them being posted. Simply search for the listings that interest you, and paste the url in CL Notifier App form. You will get periodic notifications aboute new listings on the Craigslist page.

What are some limitations of the CL Notifier App?
Due to the volume of posts on Craigslist on a daily basis, they does not update their listings pages every time someone posts something new. Each new listing may take about 20 minutes to show up in the search results. Since the CL Notifier App just watches these pages for any new listings, your notifications may contain listings that were posted within about a 30 minutes time frame.

Since this is a non-comercial application (running on free dynos on Heroku), computing resources are limited. Due to a limit on the number of email notifications I can send out daily, I can only accomodate a small number of users. Were I to add enterprise level features, I would need to charge for access to this app, which would be against the Craigslist Terms of Use.

If you would like to clone a this application to run a local version, keep reading below!

## Version Information

This application was built with ruby version 2.5.1, and rails version 5.2.1. The following instructions assume that you have these versions of ruby and rails installed.

## Cloning and Getting Started

To clone the application and install its dependencies, run: 

```
$ git clone git@github.com:QED0711/craigslist-notifier.git
$ cd criagslist-notifier
$ bundle install
$ rake db:migrate RAILS_ENV=development
$ rails s
```
You should be able to view the app at http://localhost:3000. You will not, however, be able to sign in or perform any other actions that require user authentication at this point. To do that, you will need to setup some environment variables and your database. 

Note: If you have problems with postgresql (or just want to use the lighter weight sqlite3), you can change your database to use sqlite3. 

In config/database.yml, change all instances of 'postgresql' to 'sqlite3'

In the Gemfile, comment out the 'pg' gem, and add "gem 'sqlite3'"

## Setting Up ENV Variables

This application uses figaro to manage environment variables. you will need to create a file called "application.yml" in the app/config folder. You can do this with the following commands (assuming you are already in the craigslist-notifier directory):
```
$ touch config/application.yml
```
In this newly created file, you will add all your environment variables in the following format:
```
test_email: "test@email.com"
```
For basic user and admin functionality (allowing new users), you will need to defined the following environment variables:

```
### Needed for Notifications ###
default_mailer
gmail_username
gmail_password

### Needed to define a default admin user. Alternatively, define in seed.rb ###
test_user_1_email
test_user_1_password
admin_email

### Needed to allow for new user access through the application interface. May omit if you don't need this feature ###
token_1
token_2
token_auth
```
default_mailer: The email address you will use to send notifications from. This is currently set to be a gmail address, but you can change this if you like (not covered in this README). I just created a new gmail address for this.

gmail_username: E.G. if the gmail account you are using is test@gmail.com, then your username is "test".

gmail_password: The password to your gmail account.

test_user_1_email: The email account you would like to use to sign in. This will also be the admin email (see below)

test_user_1_password: The default password for your test_user_1_email.

admin_email: The same as test_user_1_email. This will allow you to grant access to other users. 

token_1 & token_2: These should be strings of random letters and numbers. Using these strings, the program will create random authentication tokens that new users can use to gain access to the application. If you intend this for personal use only, you do not need to define these. 

token_auth: A regular expression search pattern that will be used to authenticate tokens. it could look something like this:
"RANDOMCHARS[token_1 value]{10}RANDOMCHARS[token_2 value]{13}"
This essentially takes the token_1 and token_2 values that you defined before, and places them into a regular express. You can make this as simple or complex as you like. 

## Setting Up Your Database with Seed Data

Now, we need to create some seed data. If you defined all the test_user environment variables above, you can skip this step. If not, navigate to db/seeds.rb and add a new user like this:
```
User.create(email: "some_email@email.com", password: "super_secret_password", authorization: "admin")
```
If you leave off the authorization portion, the user will be added without admin priviledges. 

You can add as many users as you like here using the format above.

With you seed data in place, run:
```
rake db:seed
```

After these have finished running, you can check to make sure everything is working by doing the following:

```
$ rails c
(enter the rails console)
$ User.first
(should return a User Object with the same email and password that you defined as test_user_1_email and test_user_1_password or that are defined in your seed.rb file)
```

Finally, in order to get regular notifications, you will need to have a background process running. This application uses Delayed Jobs to run these background proceses. Open a new terminal window and run the following:

```
rake jobs:work
```

While these jobs are working, the application will look for new craigslist listings every 5 minutes.

Now that all your data is in place, and the application is regularly looking for new listings, run:

```
$ rails s
```

Navigate again to "http://localhost:3000", and you should now be able to sign in and create new searches. 

Happy Craigslist Searching!
