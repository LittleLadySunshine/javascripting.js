# students.gschool.it

This site is the one stop shop for gSchool students to get information about the course.

## Tech details

* Ruby 2.1.1
* Rails 4.1.4
  * Omniauth-github for authentication
  * RSpec
* CI
  * [Semaphore](https://semaphoreapp.com/galvanize-dev/students-gschool-it--2)
* Deployed to Heroku (see below)


## Contributing
* [Style Guide](https://github.com/styleguide)

### Development Environment

1. Copy config/database.yml.example to config/database.yml. Configure for your local database settings.
1. Run `rake db:create:all` to create the databases.
1. Copy the .env.example to .env and fill in the values you need from the localhost Development Environment application registered under the Galvanize-IT Github organization.
1. Run 'rake db:seed' to create the local cohort and admin user

### Setup git duet (optional)

Add a `.git-authors` file to your home directory.  See https://github.com/modcloth/git-duet for more info.

### Using `pow`

1. Link your app with pow (using powder, just use `powder link`)
1. Copy .powenv.example to .powenv
1. Make sure that your envVariables.sh points to your pow url

If you get a 404 from Github when trying to authenticate, make sure you source the envVariables.sh file into the console
window that your server is running in. Not having the env variables is what causes the 404 error.

### Email in development
Development is set up to send all email to [Mailcatcher](http://mailcatcher.me/). Mailcatcher [can not be put into the Gemfile](http://mailcatcher.me/#bundler) so you will need to install it separately via `gem install mailcatcher`.

## Testing
Run `rspec spec` to run all of the tests.

You can also use [Guard](https://github.com/guard/guard) to automatically run your tests when a file changes using
`bundle exec guard` at the command line. If you don't want the [Pry](https://github.com/pry/pry) prompt, use `guard --no-interaction`.

## Review Environment
[http://students-gschool-review.herokuapp.com/](http://students-gschool-review.herokuapp.com/)
