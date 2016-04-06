install: ruby node git config

ruby:
				# cd ~/.rbenv/plugins/ruby-build && git pull && popd
				rbenv install -s
				rbenv exec gem install bundler
				rbenv exec bundle install

node:
				. ~/.nvm/nvm.sh
				nvm install
				npm install
				./node_modules/bower/bin/bower install

git:
				git submodule init
				git submodule update
				grep '"version"' ./vendor/dist/package.json


config:
				ln -sv ./config/database.yml.example ./config/database.yml
				ln -sv ./config/secrets.yml.example ./config/secrets.yml
				ln -sv ./config/chewy.yml.example ./config/chewy.yml

db:
				rbenv exec bundle exec rake db:drop db:create db:schema:load
				#rbenv exec bundle exec rake db:drop db:create
				#rbenv exec bundle exec rake db:migrate
