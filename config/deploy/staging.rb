set :application, 'stage.aydamaster.ru'
set :stage, :production
set :scm, :git
set :repo_url, 'git@github.com:BrandyMint/BML.git' if ENV['USE_LOCAL_REPO'].nil?
set :bundle_without, %w(development test).join(' ')
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, -> { "/home/wwwbml/#{fetch(:application)}" }

server 'icfdev.ru', user: 'wwwbml', port: 256, roles: %w(web app db)

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :rails_env, :production
set :branch, ENV['BRANCH'] || 'master'
fetch(:default_env)[:rails_env] = :production
