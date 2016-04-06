OS := $(shell uname)
RAKE := rbenv exec bundle exec rake
NPM := $(shell brew --prefix nvm)

all: install database

install: ruby npm bower git_modules configure

ruby:
				# cd ~/.rbenv/plugins/ruby-build && git pull && popd
				cat .ruby-version
				rbenv install -s
				rbenv version
				rbenv exec bundler || rbenv exec gem install bundler
				rbenv exec bundle install

ifeq ($(OS),Darwin)
npm:
				@echo "Darwin"
				export NVM_DIR=~/.nvm
				. $(shell brew --prefix nvm)/nvm.sh
				npm install
else
npm:
				. ~/.nvm/nvm.sh && nvm install
				npm install
endif

bower:
				./node_modules/.bin/bower install

git_modules:
				git submodule init
				git submodule update
				grep '"version"' ./vendor/dist/package.json


configure:
				ln -sv ./database.yml.example ./config/database.yml
				ln -sv ./secrets.yml.example ./config/secrets.yml
				ln -sv ./chewy.yml.example ./config/chewy.yml

database:
				# rbenv exec bundle exec rake db:drop db:create db:schema:load
				$(RAKE) db:drop db:create

				# Миграции приходится делать отдельно, потому что только так срабатывают миграции из openbill
				$(RAKE) db:migrate
