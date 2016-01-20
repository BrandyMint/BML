source 'https://rubygems.org'
require './lib/gemfile_support'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

gem 'settingslogic'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'phone', github: 'BrandyMint/phone', branch: 'feature/russia'
gem 'nprogress-rails'
# gem 'semver2'
# gem 'pg'

gem 'virtus'

gem 'react-source'
gem 'react-rails'

gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'sidekiq'

gem 'slim-rails'

gem 'cocoon'
gem 'simple-navigation', git: 'git://github.com/andi/simple-navigation.git'
gem 'simple-navigation-bootstrap'

gem 'font-awesome-rails'
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git'

gem 'active_link_to'
gem 'uuid'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'bond'
  gem 'jist'
  gem 'pry-rails'
  gem 'pry-theme'

  gem 'pry-pretty-numeric'
  gem 'pry-highlight'
  # Start a pry session whenever something goes wrong.
  # Не испольуем потому что есть better_errors
  # gem 'pry-rescue'

  # step, next, finish, continue, break
  gem 'pry-nav'
  gem 'pry-doc'
  gem 'pry-docmore'

  # Добавляет show-stack
  gem 'pry-stack_explorer'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'

  gem 'listen', '~> 3.0'
  gem 'guard', '> 2.12'
  gem 'terminal-notifier-guard', '~> 1.6.1', require: darwin_only('terminal-notifier-guard')

  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'guard-shell'
  gem 'guard-bundler'
  gem 'guard-ctags-bundler'
  gem 'guard-rubocop'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

