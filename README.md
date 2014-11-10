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

1. Copy `config/database.yml.example` to `config/database.yml`. Configure for your local database settings.
1. Run `rake db:create db:schema:load` to create the databases.
1. Copy the `.env.example` to `.env` and fill in the values you need from the localhost Development Environment application registered under the Galvanize-IT Github organization.
1. Run 'rake db:seed' to create the local cohort and admin user

NOTE: to log in as a student and an instructor locally, you'll need to
create two separate github accounts.

### Setup git duet (optional)

Add a `.git-authors` file to your home directory.  See https://github.com/modcloth/git-duet for more info.

### Email in development

Development is set up to send all email to [Mailcatcher](http://mailcatcher.me/). Mailcatcher [can not be put into the Gemfile](http://mailcatcher.me/#bundler) so you will need to install it separately via `gem install mailcatcher`.

## Testing

Run `rspec spec` to run all of the tests.

You can also use [Guard](https://github.com/guard/guard) to automatically run your tests when a file changes using
`bundle exec guard` at the command line. If you don't want the [Pry](https://github.com/pry/pry) prompt, use `guard --no-interaction`.

## Review Environment

[http://students-gschool-review.herokuapp.com/](http://students-gschool-review.herokuapp.com/)
