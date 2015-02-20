source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby "2.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development do
  gem 'chef', '~> 11.12.8'
  gem 'berkshelf', '~> 3.1.4'
  gem 'knife-solo', '~> 0.4.2'
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rails', '~> 1.1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano3-unicorn', '~> 0.2.1'
  gem 'bullet', '~> 4.13.0'
  #gem 'rails_best_practices', '~> 1.15.4', require: false
  #gem 'rubycritic', '~> 1.1.1', require: false
  #gem 'powder', '~> 0.2.1', require: false
  #gem 'brakeman', '~> 2.6.1', require: false
  #gem 'rubocop', '~> 0.25.0', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.2'
end

group :test do
  gem 'simplecov', '~> 0.9.0', require: false
  gem 'shoulda-matchers', '~> 2.6.2'
  gem 'capybara', '~> 2.4.1'
  gem 'poltergeist', '~> 1.5.1'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'launchy', '~> 2.4.2'
  gem 'coveralls', '~> 0.7.0', require: false
end

group :production, :staging do
  gem 'unicorn', '~> 4.8.3'
  gem 'rails_12factor', '~> 0.0.2'
  gem 'pg', '~> 0.17.1'
end

group :production do
  gem 'newrelic_rpm'
end

# Rails
gem 'slim-rails', '~> 2.1.5'
gem 'rails-i18n', '~> 4.0.2'
gem 'rb-readline', '~> 0.5.1'

# Bootstrap
gem 'bootstrap-sass', '~> 3.2.0.0'
gem 'autoprefixer-rails', '~> 2.1.1.20140710'
gem 'font-awesome-rails', '~> 4.1.0.0'

# Assets
gem 'rails-assets-vue', '~> 0.10.6'
gem 'rails-assets-underscore', '~> 1.6.0'
gem 'rails-assets-google-code-prettify', '~> 1.0.2'
gem 'rails-assets-mousetrap', '~> 1.4.6'
gem 'rails-assets-moment', '~> 2.8.1'
gem 'rails-assets-typeahead.js', '~> 0.10.4'
gem 'rails-assets-jquery-textcomplete', '~> 0.2.4'
# https://github.com/bassjobsen/typeahead.js-bootstrap-css

gem 'omniauth-github', '~> 1.1.2'
gem 'cancancan', '~> 1.9.1'
gem 'redcarpet', '~> 3.1.2'
gem 'kaminari', '~> 0.16.1'
gem 'ransack', '~> 1.2.3'
gem 'sequenced', '~> 1.6.0'
gem 'acts-as-taggable-on', '~> 3.3.0'
gem 'exception_notification', '~> 4.0.1'
gem 'nokogiri', '~> 1.6.3.1'

