source 'https://rubygems.org'
ruby '3.2.0'

gem 'rails', '~> 7.1'
gem 'pg'
gem 'puma'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
gem 'sprockets-rails'

# HTTP + HTML parsing
gem 'http'
gem 'nokogiri'

# Background jobs
gem 'sidekiq'

# Utilities
gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem 'pry'
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'brakeman', require: false
  gem 'rubocop-rails-omakase', require: false
end

group :development do
  gem 'web-console'
  gem 'dotenv-rails'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
