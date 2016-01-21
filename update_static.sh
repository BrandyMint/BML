
git submodule init
# git submodule update
git submodule foreach git pull
rm -fr ./public/assets/
rm -fr ./tmp/cache

cp vendor/dist/dist/stylesheets/themes/theme1.css public/stylesheets
