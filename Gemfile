ruby "2.1.3"

source "https://rubygems.org"

gem "rails"
gem "pg"
gem "sass-rails"
gem "font-awesome-sass"
gem "haml"
gem "uglifier"
gem "coffee-rails"
gem "jquery-rails"
gem "omniauth-github"
gem "github-markup"
gem "github-markdown"
gem "underscore-rails"
gem "neat", "1.5.1"
gem "acts-as-taggable-on"
gem "zeroclipboard-rails"
gem "rmagick", :require => 'RMagick'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'faraday', '~> 0.9.0'

gem "carrierwave"
gem "fog"

group :development, :test do
  gem "hologram"
  gem "guard-hologram", require: false
  gem "dotenv-rails"
  gem "spring"
  gem "spring-commands-rspec"
  gem "launchy"
  gem "rspec-rails"
  gem "rspec-mocks"
  gem "capybara"
  gem "selenium-webdriver"
  gem "git-duet"
  gem "byebug"
  gem "timecop"
  gem "webmock", "~> 1.19.0"
  gem "vcr", "~> 2.9.3"
end

group :review, :production do
  gem "rails_12factor"
end
