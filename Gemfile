source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'

gem 'pg', '~> 1.2'

# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'

# HTML select list for countries
gem 'country_select'

# Common translations
gem 'rails-i18n'

# for the test suite and tasks
gem 'database_cleaner'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Speed up boot time
gem 'bootsnap', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'rails-controller-testing'
  gem 'cucumber-rails', :require => false
  gem 'selenium-webdriver'
  gem 'factory_bot_rails'
  gem 'email_spec'
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'

  gem 'capistrano', '3.6.1'
  gem 'capistrano-maintenance', require: false
  gem 'capistrano-server', git: 'https://github.com/JS-Tech/capistrano-server'
  # rails specific capistrano funcitons
  gem 'capistrano-rails'
  # integrate bundler with capistrano
  gem 'capistrano-bundler'
  # if you are using RVM
  gem 'capistrano-rvm'
  gem 'rails-erd'
end

# authentication & authorization
gem 'adeia'

gem 'snaptable'

gem 'bcrypt'

# inline css in mailer
gem 'nokogiri'
gem 'premailer-rails'

# error tracking with sentry
gem 'sentry-raven'

# File upload
gem 'carrierwave', '~> 1.3'
gem 'carrierwave-i18n'
gem 'mini_magick' # brew install graphicsmagick
gem 'carrierwave-imageoptimizer' # brew install optipng jpegoptim
gem 'fog-google'

# Pagination
gem 'will_paginate'

# PDF generation
gem 'prawn'

# Barcode generation
gem 'barby'
gem 'rqrcode'

# Push notifications / rpush init on update
gem 'rpush', '~> 5'

# HTTP client
gem 'rest-client'

# Style guide css
gem 'livingstyleguide'

# Markdown parser
gem 'redcarpet'