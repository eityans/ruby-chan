# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '7.0.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 6.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.0.1'
end

group :development do
  gem 'listen', '~> 3.7'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1.0'

  gem 'annotate'
  gem 'dotenv-rails'
  gem 'pre-commit', require: false
  gem 'rubocop', require: false
  gem 'squasher'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'line-bot-api'
gem 'pry-byebug'

gem 'factory_bot'

# Windowsで利用できないgemをインストールするため、platformsを追加している。
# cf. https://bundler.io/man/gemfile.5.html
gem 'magic_cloud', '~> 0.0.4', platforms: :ruby

# https://stackoverflow.com/questions/65479863/rails-6-1-ruby-3-0-0-tests-error-as-they-cannot-load-rexml
gem 'rexml'
