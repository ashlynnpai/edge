source 'https://rubygems.org'
ruby '2.1.5'


gem 'rails', '4.1.7'
gem 'pg'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'haml-rails'
gem 'bcrypt-ruby'
gem 'figaro'


group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
  gem 'fabrication'
  gem 'faker'
  gem 'vcr'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'webmock'
end

group :production, :staging do
  gem 'rails_12factor'
end

