OS := $(shell uname)
RAKE = rbenv exec bundle exec rake

install: ruby npm bower git config

all: install database

ruby:
				# cd ~/.rbenv/plugins/ruby-build && git pull && popd
				cat .ruby-version
				rbenv install -s
				rbenv version
				rbenv exec gem install bundler
				rbenv exec bundle install

ifeq ($(OS),Darwin)
npm:
				@echo "Darwin"
				export NVM_DIR=~/.nvm
				. $(brew --prefix nvm)/nvm.sh
				npm install
else
npm:
				. ~/.nvm/nvm.sh && nvm install
				npm install
endif

bower:
				./node_modules/.bin/bower install

git:
				git submodule init
				git submodule update
				grep '"version"' ./vendor/dist/package.json


config:
				ln -sv ./config/database.yml.example ./config/database.yml
				ln -sv ./config/secrets.yml.example ./config/secrets.yml
				ln -sv ./config/chewy.yml.example ./config/chewy.yml

database:
				# rbenv exec bundle exec rake db:drop db:create db:schema:load
				$(RAKE) db:drop db:create
				$(RAKE) rake db:migrate
