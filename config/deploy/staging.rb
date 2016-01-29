set :application, 'aydamaster.ru'
set :stage, :staging
set :scm, :git
if ENV['USE_LOCAL_REPO'].nil?
  set :repo_url, 'git@github.com:BrandyMint/BML.git'
end
set :bundle_without, %w(development test).join(' ')
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, -> { "/home/wwwkiiiosk/#{fetch(:application)}" }

server '136.243.171.131', user: 'wwwkiiiosk', port: 2222, roles: %w(web app db)

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :rails_env, :staging
set :branch, ENV['BRANCH'] || 'master'
fetch(:default_env).merge!(rails_env: :staging)
