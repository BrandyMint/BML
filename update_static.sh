
git submodule init
# git submodule update
git submodule foreach git pull
rm -fr ./public/assets/
rm -fr ./tmp/cache
