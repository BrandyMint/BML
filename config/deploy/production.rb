set :application, 'bmland.ru'
set :stage, :production
set :scm, :git
if ENV['USE_LOCAL_REPO'].nil?
  set :repo_url, 'git@github.com:BrandyMint/BML.git'
end
set :bundle_without, %w(development test).join(' ')
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :deploy_to, -> { "/home/wwwbml/#{fetch(:application)}" }

server '176.9.83.4', user: 'wwwbml', port: 22, roles: %w(web app db)

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :rails_env, :production
set :branch, ENV['BRANCH'] || 'master'
fetch(:default_env).merge!(rails_env: :production)
