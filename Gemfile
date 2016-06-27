source 'https://rubygems.org'
require './lib/gemfile_support'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
  gem 'rails-assets-better-i18n-plugin'
  gem 'rails-assets-better-popover-plugin'
  gem 'rails-assets-better-form-validation'
  gem 'rails-assets-lodash'
end

gem 'settingslogic'

gem 'rollout'

gem 'petrovich'

# Openbill
#
gem 'sequel'
gem 'money'
gem 'money-rails', github: 'RubyMoney/money-rails'

gem 'sprockets', '>=3.0.0.beta'
gem 'sprockets-es6'

gem 'redis-session-store'

gem 'activeadmin', github: 'activeadmin/activeadmin'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'

gem 'pg_search'

gem 'openbill-ruby', github: 'openbill-service/openbill-ruby'
# gem 'openbill-ruby', path: '../openbill-ruby'

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
gem 'semver2'
# gem 'pg'

gem 'hiredis'
# gem 'redis', '>= 2.2.0', require: ['redis', 'redis/connection/hiredis']
gem 'redis', require: ['redis', 'redis/connection/hiredis']
gem 'redis-namespace'
gem 'redis-objects'

gem 'non-stupid-digest-assets'

# Только для JS
gem 'bootstrap', '~> 4.0.0.alpha3'

gem 'gravatarify'

gem 'bugsnag'

gem 'rack-cors', require: 'rack/cors'

# gem 'yandex-api'
# gem 'yandex-api-direct'

# OMNIAUTH
#
gem 'omniauth'
# gem 'negval-omniauth-yandex'
gem 'omniauth-yandex'
# gem 'omniauth-yandex', github: 'TimothyKlim/omniauth-yandex'
gem 'omniauth-twitter'
gem 'sorcery'
gem 'pundit'

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
# gem 'grape-swagger-ui', github: 'kb-platform/grape-swagger-ui'
# gem 'grape-swagger-ui', path: '../grape-swagger-ui'
# gem 'swagger-ui_rails'
gem 'hashie-forbidden_attributes'
# markdown для grape
gem 'kramdown'

gem 'poltergeist'
gem 'capybara'

# gem 'mimemagic'
gem 'mini_magick'
gem 'carrierwave'

gem 'ranked-model'
gem 'virtus'
gem 'hashie'

gem 'execjs'

gem 'addressable'

# Just add/require this gem after/instead (implicit) execjs gem. The latter will be monkey-patched.
# Глюячная фигня, но идея хорошая
# gem 'execjs-xtrn'

gem 'react-rails', github: 'jakegavin/react-rails', branch: 'react-15-0-1'

gem 'kaminari'
gem 'bootstrap-kaminari-views', git: 'https://github.com/klacointe/bootstrap-kaminari-views', branch: 'bootstrap4'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'sidekiq-reset_statistics'
gem 'sidekiq-failures', github: 'mhfs/sidekiq-failures'
gem 'sidekiq-unique-jobs'
gem 'sidekiq-status'
# gem 'sidekiq-statsd'
gem 'sidekiq', '~> 3.5.0'
gem 'sidekiq-cron'

gem 'slim-rails'

gem 'cocoon'
gem 'simple-navigation', git: 'git://github.com/andi/simple-navigation.git'
gem 'simple-navigation-bootstrap'

gem 'font-awesome-rails'
gem 'simple_form', git: 'git://github.com/plataformatec/simple_form.git'

gem 'active_link_to'
gem 'uuid'

gem 'enumerize'
gem 'validates'
gem 'smsc'
gem 'i18n-js', github: 'fnando/i18n-js'
gem 'russian'
gem 'gon'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

gem 'simpleidn'
gem 'public_suffix'
gem 'babosa'
gem 'strip_attributes'

gem 'cloud_payments', github: 'undr/cloud_payments'
gem 'http_logger'

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

  gem 'factory_girl_rails'
  gem 'rspec'
  gem 'rspec-rails'

  gem 'listen', '~> 3.0'
  gem 'guard', '> 2.12'
  gem 'terminal-notifier-guard', '~> 1.6.1', require: darwin_only('terminal-notifier-guard')

  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'guard-shell'
  gem 'guard-bundler'
  gem 'guard-ctags-bundler'
  gem 'guard-rubocop'
  gem 'rubocop-rspec'

  # Открывает письма прямо в браузере
  # gem 'letter_opener'
end

group :test do
  gem 'email_spec'
  gem 'rspec-collection_matchers'
  gem 'rack_session_access'
  gem 'test_after_commit'
  gem 'capybara-email'
  gem 'capybara-screenshot'
  gem 'webmock'
  gem 'vcr', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-rubocop'
end

group :deploy do
  gem 'capistrano', '~> 3.1', require: false
  gem 'capistrano-rbenv', '~> 2.0', require: false
  gem 'capistrano-rails', '~> 1.1.3', require: false
  gem 'capistrano-bundler', require: false

  # Используем planetio/capistrano-db-tasks
  # потому что у него есть dump_cmd_flags через который передается список таблиц для игнора
  #
  gem 'capistrano-db-tasks', require: false, github: 'planetio/capistrano-db-tasks'
end
